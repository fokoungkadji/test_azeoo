import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../cache/cache_manager.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();

  final cacheManager = getIt<CacheManager>();
  await cacheManager.initialize();
}
