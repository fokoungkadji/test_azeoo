import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// Configuration du cache
abstract class CacheConfig {
  CacheConfig._();

  /// Durée de vie du cache en minutes
  static const int cacheDurationMinutes = 5;

  /// Nom de la box Hive pour le cache utilisateur
  static const String userCacheBox = 'user_cache';

  /// Clé pour stocker le timestamp du cache
  static const String cacheTimestampSuffix = '_timestamp';
}

/// Gestionnaire de cache utilisant Hive
///
/// Fournit des méthodes pour stocker, récupérer et invalider
/// les données en cache avec gestion du TTL.
@lazySingleton
class CacheManager {
  CacheManager();

  late Box<dynamic> _box;
  bool _isInitialized = false;

  /// Initialise le cache manager
  Future<void> initialize() async {
    if (_isInitialized) return;

    await Hive.initFlutter();
    _box = await Hive.openBox(CacheConfig.userCacheBox);
    _isInitialized = true;
  }

  /// Vérifie si le cache manager est initialisé
  bool get isInitialized => _isInitialized;

  /// Stocke une valeur en cache avec une clé donnée
  ///
  /// [key] La clé unique pour identifier la donnée
  /// [value] La valeur à stocker (doit être sérialisable)
  Future<void> put(String key, dynamic value) async {
    _ensureInitialized();

    await _box.put(key, value);
    await _box.put(
      '$key${CacheConfig.cacheTimestampSuffix}',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Récupère une valeur du cache
  ///
  /// [key] La clé de la donnée à récupérer
  ///
  /// Retourne `null` si la donnée n'existe pas ou si le cache a expiré.
  T? get<T>(String key) {
    _ensureInitialized();

    if (!_isCacheValid(key)) {
      return null;
    }

    return _box.get(key) as T?;
  }

  /// Vérifie si une clé existe en cache et n'est pas expirée
  bool hasValidCache(String key) {
    _ensureInitialized();
    return _isCacheValid(key);
  }

  /// Supprime une valeur du cache
  Future<void> remove(String key) async {
    _ensureInitialized();

    await _box.delete(key);
    await _box.delete('$key${CacheConfig.cacheTimestampSuffix}');
  }

  /// Vide tout le cache
  Future<void> clear() async {
    _ensureInitialized();
    await _box.clear();
  }

  /// Vérifie si le cache pour une clé donnée est encore valide
  bool _isCacheValid(String key) {
    final data = _box.get(key);
    if (data == null) return false;

    final timestamp =
        _box.get('$key${CacheConfig.cacheTimestampSuffix}') as int?;

    if (timestamp == null) return false;

    final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final now = DateTime.now();
    final difference = now.difference(cacheTime);

    return difference.inMinutes < CacheConfig.cacheDurationMinutes;
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        "CacheManager n'est pas initialisé. "
        "Appelez initialize() avant d'utiliser le cache.",
      );
    }
  }
}
