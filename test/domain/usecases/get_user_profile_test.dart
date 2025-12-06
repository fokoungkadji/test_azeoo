import 'package:azeoo_profile_sdk/src/core/error/failures.dart';
import 'package:azeoo_profile_sdk/src/domain/usecases/get_user_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_helpers.dart';

void main() {
  late GetUserProfile useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserProfile(mockRepository);
  });

  group('GetUserProfile', () {
    test('should get user profile from repository', () async {
      // Arrange
      when(() => mockRepository.getUserProfile(
            userId: any(named: 'userId'),
            forceRefresh: any(named: 'forceRefresh'),
          )).thenAnswer((_) async => const Right(TestData.testUser));

      // Act
      final result = await useCase(
        const GetUserProfileParams(userId: TestData.testUserId),
      );

      // Assert
      expect(result, const Right(TestData.testUser));
      verify(() => mockRepository.getUserProfile(
            userId: TestData.testUserId,
            forceRefresh: false,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should pass forceRefresh parameter to repository', () async {
      // Arrange
      when(() => mockRepository.getUserProfile(
            userId: any(named: 'userId'),
            forceRefresh: any(named: 'forceRefresh'),
          )).thenAnswer((_) async => const Right(TestData.testUser));

      // Act
      await useCase(
        const GetUserProfileParams(
          userId: TestData.testUserId,
          forceRefresh: true,
        ),
      );

      // Assert
      verify(() => mockRepository.getUserProfile(
            userId: TestData.testUserId,
            forceRefresh: true,
          )).called(1);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      const failure = ServerFailure(message: 'Server error');
      when(() => mockRepository.getUserProfile(
            userId: any(named: 'userId'),
            forceRefresh: any(named: 'forceRefresh'),
          )).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(
        const GetUserProfileParams(userId: TestData.testUserId),
      );

      // Assert
      expect(result, const Left(failure));
    });

    test('should return NetworkFailure when network is unavailable', () async {
      // Arrange
      const failure = NetworkFailure(message: 'No internet connection');
      when(() => mockRepository.getUserProfile(
            userId: any(named: 'userId'),
            forceRefresh: any(named: 'forceRefresh'),
          )).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(
        const GetUserProfileParams(userId: TestData.testUserId),
      );

      // Assert
      expect(result, const Left(failure));
      expect(result.fold((l) => l, (r) => null), isA<NetworkFailure>());
    });

    test('should return NotFoundFailure when user does not exist', () async {
      // Arrange
      const failure = NotFoundFailure(message: 'User not found');
      when(() => mockRepository.getUserProfile(
            userId: any(named: 'userId'),
            forceRefresh: any(named: 'forceRefresh'),
          )).thenAnswer((_) async => const Left(failure));

      // Act
      final result = await useCase(
        const GetUserProfileParams(userId: '999'),
      );

      // Assert
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<NotFoundFailure>());
    });
  });

  group('GetUserProfileParams', () {
    test('should have default forceRefresh as false', () {
      const params = GetUserProfileParams(userId: '1');
      expect(params.forceRefresh, false);
    });

    test('should accept forceRefresh parameter', () {
      const params = GetUserProfileParams(userId: '1', forceRefresh: true);
      expect(params.forceRefresh, true);
    });
  });
}
