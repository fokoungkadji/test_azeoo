import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../bloc/profile_cubit.dart';
import '../pages/profile_page.dart';

/// Configuration des routes de l'application
///
/// Utilise go_router pour une navigation déclarative et scalable.
class AppRouter {
  AppRouter._();

  /// Noms des routes
  static const String profileRoute = '/profile';

  /// Configuration du router
  static GoRouter createRouter({String? initialUserId}) {
    return GoRouter(
      initialLocation: profileRoute,
      routes: [
        GoRoute(
          path: profileRoute,
          name: 'profile',
          builder: (context, state) {
            // Récupérer l'userId depuis les query parameters ou la configuration
            final userId =
                state.uri.queryParameters['userId'] ?? initialUserId ?? '1';

            return BlocProvider<ProfileCubit>(
              create: (_) => getIt<ProfileCubit>()..loadProfile(userId),
              child: const ProfilePage(),
            );
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page non trouvée',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
