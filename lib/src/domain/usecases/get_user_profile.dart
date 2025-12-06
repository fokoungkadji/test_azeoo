import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserProfileParams {
  const GetUserProfileParams({
    required this.userId,
    this.forceRefresh = false,
  });

  final String userId;
  final bool forceRefresh;
}

@lazySingleton
class GetUserProfile {
  const GetUserProfile(this._repository);

  final UserRepository _repository;

  Future<Either<Failure, User>> call(GetUserProfileParams params) {
    return _repository.getUserProfile(
      userId: params.userId,
      forceRefresh: params.forceRefresh,
    );
  }
}
