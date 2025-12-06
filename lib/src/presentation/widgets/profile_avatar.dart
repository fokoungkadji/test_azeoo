import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

/// Widget affichant l'avatar de l'utilisateur
///
/// Affiche l'image de profil si disponible, sinon affiche
/// les initiales de l'utilisateur sur un fond coloré.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.user,
    this.radius = 60,
    super.key,
  });

  /// L'utilisateur dont on affiche l'avatar
  final User user;

  /// Le rayon du cercle de l'avatar
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (user.avatarUrl != null && user.avatarUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: user.avatarUrl!,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: radius,
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => _buildPlaceholder(theme),
        errorWidget: (context, url, error) => _buildInitialsAvatar(theme),
      );
    }

    return _buildInitialsAvatar(theme);
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      child: SizedBox(
        width: radius,
        height: radius,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar(ThemeData theme) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Text(
        user.initials,
        style: TextStyle(
          fontSize: radius * 0.6,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
