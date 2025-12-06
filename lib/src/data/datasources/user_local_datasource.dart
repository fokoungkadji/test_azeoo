import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../core/cache/cache_manager.dart';
import '../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel?> getCachedUserProfile(String userId);

  Future<void> cacheUserProfile(String userId, UserModel user);

  bool hasValidCache(String userId);

  Future<void> clearUserProfile(String userId);

  Future<void> clearAll();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  UserLocalDataSourceImpl(this._cacheManager);

  final CacheManager _cacheManager;

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
