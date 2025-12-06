import 'package:azeoo_profile_sdk/src/core/error/failures.dart';
import 'package:azeoo_profile_sdk/src/domain/usecases/get_user_profile.dart';
import 'package:azeoo_profile_sdk/src/presentation/bloc/profile_cubit.dart';
import 'package:azeoo_profile_sdk/src/presentation/bloc/profile_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_helpers.dart';

void main() {
  late ProfileCubit cubit;
  late MockGetUserProfile mockGetUserProfile;

  setUpAll(() {
    registerFallbackValue(const GetUserProfileParams(userId: '1'));
  });

  setUp(() {
    mockGetUserProfile = MockGetUserProfile();
    cubit = ProfileCubit(mockGetUserProfile);
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state should be ProfileInitial', () {
    expect(cubit.state, const ProfileState.initial());
  });

  group('loadProfile', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, loaded] when loadProfile succeeds',
      build: () {
        when(() => mockGetUserProfile(any()))
            .thenAnswer((_) async => const Right(TestData.testUser));
        return ProfileCubit(mockGetUserProfile);
      },
      act: (cubit) => cubit.loadProfile(TestData.testUserId),
      expect: () => [
        const ProfileState.loading(),
        const ProfileState.loaded(user: TestData.testUser),
      ],
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits [loading, error] when loadProfile fails',
      build: () {
        when(() => mockGetUserProfile(any())).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server error')),
        );
        return ProfileCubit(mockGetUserProfile);
      },
      act: (cubit) => cubit.loadProfile(TestData.testUserId),
      expect: () => [
        const ProfileState.loading(),
        isA<ProfileError>(),
      ],
    );

    test('sets currentUserId when loadProfile is called', () async {
      when(() => mockGetUserProfile(any()))
          .thenAnswer((_) async => const Right(TestData.testUser));

      await cubit.loadProfile(TestData.testUserId);

      expect(cubit.currentUserId, TestData.testUserId);
    });
  });

  group('refreshProfile', () {
    test('does nothing when currentUserId is null', () async {
      final initialState = cubit.state;

      await cubit.refreshProfile();

      expect(cubit.state, initialState);
      verifyNever(() => mockGetUserProfile(any()));
    });

    test('calls GetUserProfile when userId exists', () async {
      when(() => mockGetUserProfile(any()))
          .thenAnswer((_) async => const Right(TestData.testUser));

      await cubit.loadProfile(TestData.testUserId);
      reset(mockGetUserProfile);
      when(() => mockGetUserProfile(any()))
          .thenAnswer((_) async => const Right(TestData.testUser));

      await cubit.refreshProfile();

      final captured = verify(() => mockGetUserProfile(captureAny())).captured;
      expect(captured.length, 1);
      final params = captured.first as GetUserProfileParams;
      expect(params.forceRefresh, true);
    });
  });

  group('updateUserId', () {
    test('loads new profile when userId changes', () async {
      when(() => mockGetUserProfile(any()))
          .thenAnswer((_) async => const Right(TestData.testUser));

      await cubit.loadProfile(TestData.testUserId);

      when(() => mockGetUserProfile(any()))
          .thenAnswer((_) async => const Right(TestData.testUser2));

      await cubit.updateUserId(TestData.testUserId2);

      expect(cubit.currentUserId, TestData.testUserId2);
    });

    test('refreshes profile when userId is the same', () async {
      when(() => mockGetUserProfile(any()))
          .thenAnswer((_) async => const Right(TestData.testUser));

      await cubit.loadProfile(TestData.testUserId);
      reset(mockGetUserProfile);
      when(() => mockGetUserProfile(any()))
          .thenAnswer((_) async => const Right(TestData.testUser));

      await cubit.updateUserId(TestData.testUserId);

      final captured = verify(() => mockGetUserProfile(captureAny())).captured;
      expect(captured.length, 1);
      final params = captured.first as GetUserProfileParams;
      expect(params.forceRefresh, true);
    });
  });
}
