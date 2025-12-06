import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_profile.dart';
import 'profile_state.dart';

/// Cubit gérant l'état du profil utilisateur
///
/// Utilise le pattern Cubit de flutter_bloc pour gérer les états
/// de manière prévisible et testable.
@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getUserProfile) : super(const ProfileState.initial());

  final GetUserProfile _getUserProfile;

  /// L'userId actuellement chargé
  String? _currentUserId;

  /// Getter pour l'userId actuel
  String? get currentUserId => _currentUserId;

  /// Charge le profil d'un utilisateur
  ///
  /// [userId] L'identifiant de l'utilisateur à charger
  Future<void> loadProfile(String userId) async {
    _currentUserId = userId;

    // Récupérer l'utilisateur précédent si disponible
    final previousUser = _getPreviousUser();

    emit(ProfileState.loading(previousUser: previousUser));

    final result = await _getUserProfile(
      GetUserProfileParams(userId: userId),
    );

    result.fold(
      (failure) => emit(ProfileState.error(
        message: failure.toString(),
        previousUser: previousUser,
      )),
      (user) => emit(ProfileState.loaded(user: user)),
    );
  }

  /// Rafraîchit le profil actuel (force la récupération depuis l'API)
  ///
  /// Utilisé pour le pull-to-refresh
  Future<void> refreshProfile() async {
    if (_currentUserId == null) return;

    final currentUser = _getPreviousUser();

    // Si on a déjà un utilisateur, on affiche un état "refreshing"
    if (currentUser != null) {
      emit(ProfileState.loaded(user: currentUser, isRefreshing: true));
    } else {
      emit(const ProfileState.loading());
    }

    final result = await _getUserProfile(
      GetUserProfileParams(
        userId: _currentUserId!,
        forceRefresh: true,
      ),
    );

    result.fold(
      (failure) => emit(ProfileState.error(
        message: failure.toString(),
        previousUser: currentUser,
      )),
      (user) => emit(ProfileState.loaded(user: user)),
    );
  }

  /// Met à jour l'userId et recharge le profil
  ///
  /// [userId] Le nouvel identifiant utilisateur
  Future<void> updateUserId(String userId) async {
    if (userId == _currentUserId) {
      // Même userId, juste refresh
      await refreshProfile();
    } else {
      // Nouvel userId, charger depuis le début
      await loadProfile(userId);
    }
  }

  /// Récupère l'utilisateur précédemment chargé depuis l'état actuel
  User? _getPreviousUser() {
    return state.whenOrNull(
      loaded: (user, _) => user,
      error: (_, previousUser) => previousUser,
      loading: (previousUser) => previousUser,
    );
  }
}
