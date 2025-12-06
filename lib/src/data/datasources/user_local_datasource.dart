import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../core/cache/cache_manager.dart';
import '../../core/error/exceptions.dart';
import '../models/user_model.dart';

/// Interface pour la source de données locale (cache)
abstract class UserLocalDataSource {
  /// Récupère le profil utilisateur depuis le cache
  ///
  /// [userId] L'identifiant de l'utilisateur
  ///
  /// Retourne `null` si les données ne sont pas en cache ou expirées
  /// Throws [CacheException] en cas d'erreur
  Future<UserModel?> getCachedUserProfile(String userId);

  /// Sauvegarde le profil utilisateur en cache
  ///
  /// [userId] L'identifiant de l'utilisateur
  /// [user] Le modèle utilisateur à mettre en cache
  Future<void> cacheUserProfile(String userId, UserModel user);

  /// Vérifie si un profil est en cache et valide
  bool hasValidCache(String userId);

  /// Supprime le profil utilisateur du cache
  Future<void> clearUserProfile(String userId);

  /// Vide tout le cache
  Future<void> clearAll();
}

/// Implémentation de la source de données locale avec Hive
@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this._cacheManager);

  final CacheManager _cacheManager;

  /// Préfixe pour les clés de cache utilisateur
  static const String _userCachePrefix = 'user_profile_';

  String _getCacheKey(String userId) => '$_userCachePrefix$userId';

  @override
  Future<UserModel?> getCachedUserProfile(String userId) async {
    try {
      final cacheKey = _getCacheKey(userId);

      if (!_cacheManager.hasValidCache(cacheKey)) {
        return null;
      }

      final cachedData = _cacheManager.get<String>(cacheKey);

      if (cachedData == null) {
        return null;
      }

      final jsonData = jsonDecode(cachedData) as Map<String, dynamic>;
      return UserModel.fromJson(jsonData);
    } on FormatException catch (e) {
      throw CacheException(message: 'Erreur de parsing du cache: ${e.message}');
    } catch (e) {
      // En cas d'erreur, on retourne null pour permettre un fallback API
      return null;
    }
  }

  @override
  Future<void> cacheUserProfile(String userId, UserModel user) async {
    try {
      final cacheKey = _getCacheKey(userId);
      final jsonString = jsonEncode(user.toJson());
      await _cacheManager.put(cacheKey, jsonString);
    } catch (e) {
      // Ne pas faire échouer l'opération si le cache échoue
      // On pourrait logger l'erreur ici
    }
  }

  @override
  bool hasValidCache(String userId) {
    final cacheKey = _getCacheKey(userId);
    return _cacheManager.hasValidCache(cacheKey);
  }

  @override
  Future<void> clearUserProfile(String userId) async {
    final cacheKey = _getCacheKey(userId);
    await _cacheManager.remove(cacheKey);
  }

  @override
  Future<void> clearAll() async {
    await _cacheManager.clear();
  }
}
