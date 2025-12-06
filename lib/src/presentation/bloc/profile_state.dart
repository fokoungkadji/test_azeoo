import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'profile_state.freezed.dart';

/// États possibles du ProfileCubit
///
/// Utilise le pattern Union Type de Freezed pour représenter
/// les différents états de manière type-safe.
@freezed
class ProfileState with _$ProfileState {
  /// État initial avant tout chargement
  const factory ProfileState.initial() = ProfileInitial;

  /// État de chargement
  ///
  /// [previousUser] L'utilisateur précédemment chargé (pour le pull-to-refresh)
  const factory ProfileState.loading({
    User? previousUser,
  }) = ProfileLoading;

  /// État de succès avec les données utilisateur
  ///
  /// [user] L'utilisateur chargé
  /// [isRefreshing] Indique si un refresh est en cours
  const factory ProfileState.loaded({
    required User user,
    @Default(false) bool isRefreshing,
  }) = ProfileLoaded;

  /// État d'erreur
  ///
  /// [message] Le message d'erreur à afficher
  /// [previousUser] L'utilisateur précédemment chargé (permet retry)
  const factory ProfileState.error({
    required String message,
    User? previousUser,
  }) = ProfileError;
}
