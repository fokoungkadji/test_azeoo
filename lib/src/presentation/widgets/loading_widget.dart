import 'package:flutter/material.dart';

/// Widget affichant un indicateur de chargement
///
/// Affiche un spinner centré avec un message optionnel.
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.message,
    super.key,
  });

  /// Message optionnel à afficher sous le spinner
  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
