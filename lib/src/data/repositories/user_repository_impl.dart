import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, User>> getUserProfile({
    required String userId,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      try {
        final cachedUser = await _localDataSource.getCachedUserProfile(userId);

        if (cachedUser != null) {
          return Right(cachedUser.toEntity());
        }
      } on CacheException {
      }
    }

    return _fetchFromRemote(userId);
  }

  Future<Either<Failure, User>> _fetchFromRemote(String userId) async {
    try {
      final userModel = await _remoteDataSource.getUserProfile(userId);

      unawaited(_localDataSource.cacheUserProfile(userId, userModel));

      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      final cachedUser = await _tryGetExpiredCache(userId);
      if (cachedUser != null) {
        return Right(cachedUser);
      }
      return Left(NetworkFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(message: e.message));
    } on ParsingException catch (e) {
      return Left(UnexpectedFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  Future<User?> _tryGetExpiredCache(String userId) async {
    try {
      final cachedUser = await _localDataSource.getCachedUserProfile(userId);
      return cachedUser?.toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    await _localDataSource.clearAll();
  }
}
