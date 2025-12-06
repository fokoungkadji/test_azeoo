import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_profile.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getUserProfile) : super(const ProfileState.initial());

  final GetUserProfile _getUserProfile;

  String? _currentUserId;

  String? get currentUserId => _currentUserId;

  Future<void> loadProfile(String userId) async {
    _currentUserId = userId;

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

  Future<void> refreshProfile() async {
    if (_currentUserId == null) return;

    final currentUser = _getPreviousUser();

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

  Future<void> updateUserId(String userId) async {
    if (userId == _currentUserId) {
      await refreshProfile();
    } else {
      await loadProfile(userId);
    }
  }

  User? _getPreviousUser() {
    return state.whenOrNull(
      loaded: (user, _) => user,
      error: (_, previousUser) => previousUser,
      loading: (previousUser) => previousUser,
    );
  }
}
