import 'package:flutter/material.dart';

/// Widget affichant une erreur avec option de retry
///
/// Affiche un message d'erreur centré avec un bouton
/// permettant de réessayer l'action.
class ProfileErrorWidget extends StatelessWidget {
  const ProfileErrorWidget({
    required this.message,
    required this.onRetry,
    super.key,
  });

  /// Message d'erreur à afficher
  final String message;

  /// Callback appelé quand l'utilisateur appuie sur Réessayer
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icône d'erreur
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.onErrorContainer,
              ),
            ),

            const SizedBox(height: 24),

            // Titre
            Text(
              'Oups !',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 8),

            // Message d'erreur
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Bouton réessayer
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}
