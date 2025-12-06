import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';

/// Contrat abstrait pour le repository utilisateur
///
/// Définit les opérations disponibles pour accéder aux données
/// utilisateur, indépendamment de la source (API, cache, etc.).
abstract class UserRepository {
  /// Récupère le profil d'un utilisateur par son ID
  ///
  /// [userId] L'identifiant de l'utilisateur
  /// [forceRefresh] Si true, ignore le cache et récupère depuis l'API
  ///
  /// Retourne [Right(User)] en cas de succès
  /// Retourne [Left(Failure)] en cas d'erreur
  Future<Either<Failure, User>> getUserProfile({
    required String userId,
    bool forceRefresh = false,
  });

  /// Vide le cache du profil utilisateur
  Future<void> clearCache();
}
