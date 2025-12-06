import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class CacheConfig {
  CacheConfig._();

  static const int cacheDurationMinutes = 5;

  static const String userCacheBox = 'user_cache';

  static const String cacheTimestampSuffix = '_timestamp';
}

@lazySingleton
class CacheManager {
  CacheManager();

  late Box<dynamic> _box;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    await Hive.initFlutter();
    _box = await Hive.openBox(CacheConfig.userCacheBox);
    _isInitialized = true;
  }

  bool get isInitialized => _isInitialized;

  Future<void> put(String key, dynamic value) async {
    _ensureInitialized();

    await _box.put(key, value);
    await _box.put(
      '$key${CacheConfig.cacheTimestampSuffix}',
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  T? get<T>(String key) {
    _ensureInitialized();

    if (!_isCacheValid(key)) {
      return null;
    }

    return _box.get(key) as T?;
  }

  bool hasValidCache(String key) {
    _ensureInitialized();
    return _isCacheValid(key);
  }

  Future<void> remove(String key) async {
    _ensureInitialized();

    await _box.delete(key);
    await _box.delete('$key${CacheConfig.cacheTimestampSuffix}');
  }

  Future<void> clear() async {
    _ensureInitialized();
    await _box.clear();
  }

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
