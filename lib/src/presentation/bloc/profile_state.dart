import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;

  const factory ProfileState.loading({
    User? previousUser,
  }) = ProfileLoading;

  const factory ProfileState.loaded({
    required User user,
    @Default(false) bool isRefreshing,
  }) = ProfileLoaded;

  const factory ProfileState.error({
    required String message,
    User? previousUser,
  }) = ProfileError;
}
