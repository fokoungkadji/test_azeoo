import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../cache/cache_manager.dart';
import 'injection.config.dart';

/// Instance globale du service locator
final GetIt getIt = GetIt.instance;

/// Configure toutes les dépendances de l'application
///
/// Cette fonction initialise le système d'injection de dépendances
/// et doit être appelée au démarrage de l'application.
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();

  // Initialiser le cache manager après l'injection
  final cacheManager = getIt<CacheManager>();
  await cacheManager.initialize();
}
