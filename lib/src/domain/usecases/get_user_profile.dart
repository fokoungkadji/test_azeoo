import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Paramètres pour le use case GetUserProfile
class GetUserProfileParams {
  const GetUserProfileParams({
    required this.userId,
    this.forceRefresh = false,
  });

  final String userId;
  final bool forceRefresh;
}

/// Use case pour récupérer le profil d'un utilisateur
///
/// Encapsule la logique métier de récupération du profil
/// et fournit une interface claire pour la couche présentation.
@lazySingleton
class GetUserProfile {
  const GetUserProfile(this._repository);

  final UserRepository _repository;

  /// Exécute le use case
  ///
  /// [params] Les paramètres contenant l'userId et les options
  ///
  /// Retourne [Right(User)] en cas de succès
  /// Retourne [Left(Failure)] en cas d'erreur
  Future<Either<Failure, User>> call(GetUserProfileParams params) {
    return _repository.getUserProfile(
      userId: params.userId,
      forceRefresh: params.forceRefresh,
    );
  }
}
