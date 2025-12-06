import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_info.dart';

/// Page d'affichage du profil utilisateur
///
/// Gère les différents états (loading, error, loaded) et
/// supporte le pull-to-refresh.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return state.when(
            initial: () => const LoadingWidget(
              message: 'Initialisation...',
            ),
            loading: (previousUser) {
              if (previousUser != null) {
                // Afficher les données précédentes pendant le chargement
                return _buildProfileContent(
                  context,
                  user: previousUser,
                  isLoading: true,
                );
              }
              return const LoadingWidget(
                message: 'Chargement du profil...',
              );
            },
            loaded: (user, isRefreshing) => _buildProfileContent(
              context,
              user: user,
              isRefreshing: isRefreshing,
            ),
            error: (message, previousUser) {
              if (previousUser != null) {
                // Afficher les données précédentes avec un snackbar d'erreur
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showErrorSnackbar(context, message);
                });
                return _buildProfileContent(
                  context,
                  user: previousUser,
                );
              }
              return ProfileErrorWidget(
                message: message,
                onRetry: () => context.read<ProfileCubit>().refreshProfile(),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context, {
    required User user,
    bool isLoading = false,
    bool isRefreshing = false,
  }) {
    return RefreshIndicator(
      onRefresh: () => context.read<ProfileCubit>().refreshProfile(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              // Indicateur de chargement en haut si refresh
              if (isRefreshing || isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: LinearProgressIndicator(),
                ),

              // Avatar
              ProfileAvatar(user: user),

              const SizedBox(height: 32),

              // Informations du profil
              ProfileInfo(user: user),

              const SizedBox(height: 32),

              // ID utilisateur
              _buildUserIdBadge(context, user.id),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserIdBadge(BuildContext context, String userId) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.badge_outlined,
            size: 16,
            color: theme.colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 8),
          Text(
            'ID: $userId',
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Réessayer',
          onPressed: () => context.read<ProfileCubit>().refreshProfile(),
        ),
      ),
    );
  }
}
