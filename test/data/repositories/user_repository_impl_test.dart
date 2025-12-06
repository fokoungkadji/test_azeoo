import 'package:azeoo_profile_sdk/src/core/error/exceptions.dart';
import 'package:azeoo_profile_sdk/src/core/error/failures.dart';
import 'package:azeoo_profile_sdk/src/data/repositories/user_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_helpers.dart';

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;

  setUpAll(() {
    registerFallbackValue(TestData.testUserModel);
  });

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    repository = UserRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  group('getUserProfile', () {
    test('should return cached data when cache is valid', () async {
      when(() => mockLocalDataSource.getCachedUserProfile(any()))
          .thenAnswer((_) async => TestData.testUserModel);

      final result = await repository.getUserProfile(userId: TestData.testUserId);

      expect(result.isRight(), true);
      verify(() => mockLocalDataSource.getCachedUserProfile(TestData.testUserId)).called(1);
      verifyNever(() => mockRemoteDataSource.getUserProfile(any()));
    });

    test('should fetch from remote when forceRefresh is true', () async {
      when(() => mockRemoteDataSource.getUserProfile(any()))
          .thenAnswer((_) async => TestData.testUserModel);
      when(() => mockLocalDataSource.cacheUserProfile(any(), any()))
          .thenAnswer((_) async {});

      final result = await repository.getUserProfile(
        userId: TestData.testUserId,
        forceRefresh: true,
      );

      expect(result.isRight(), true);
      verify(() => mockRemoteDataSource.getUserProfile(TestData.testUserId)).called(1);
    });

    test('should fetch from remote when cache is empty', () async {
      when(() => mockLocalDataSource.getCachedUserProfile(any()))
          .thenAnswer((_) async => null);
      when(() => mockRemoteDataSource.getUserProfile(any()))
          .thenAnswer((_) async => TestData.testUserModel);
      when(() => mockLocalDataSource.cacheUserProfile(any(), any()))
          .thenAnswer((_) async {});

      final result = await repository.getUserProfile(userId: TestData.testUserId);

      expect(result.isRight(), true);
      verify(() => mockRemoteDataSource.getUserProfile(TestData.testUserId)).called(1);
    });

    test('should return ServerFailure on ServerException', () async {
      when(() => mockLocalDataSource.getCachedUserProfile(any()))
          .thenAnswer((_) async => null);
      when(() => mockRemoteDataSource.getUserProfile(any()))
          .thenThrow(const ServerException(message: 'Error', statusCode: 500));

      final result = await repository.getUserProfile(userId: TestData.testUserId);

      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (r) => fail('Should be Left'),
      );
    });

    test('should return NetworkFailure on NetworkException', () async {
      when(() => mockLocalDataSource.getCachedUserProfile(any()))
          .thenAnswer((_) async => null);
      when(() => mockRemoteDataSource.getUserProfile(any()))
          .thenThrow(const NetworkException(message: 'No connection'));

      final result = await repository.getUserProfile(userId: TestData.testUserId);

      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<NetworkFailure>()),
        (r) => fail('Should be Left'),
      );
    });

    test('should return NotFoundFailure on NotFoundException', () async {
      when(() => mockLocalDataSource.getCachedUserProfile(any()))
          .thenAnswer((_) async => null);
      when(() => mockRemoteDataSource.getUserProfile(any()))
          .thenThrow(const NotFoundException(message: 'Not found'));

      final result = await repository.getUserProfile(userId: TestData.testUserId);

      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<NotFoundFailure>()),
        (r) => fail('Should be Left'),
      );
    });
  });

  group('clearCache', () {
    test('should call clearAll on local data source', () async {
      when(() => mockLocalDataSource.clearAll()).thenAnswer((_) async {});

      await repository.clearCache();

      verify(() => mockLocalDataSource.clearAll()).called(1);
    });
  });
}
