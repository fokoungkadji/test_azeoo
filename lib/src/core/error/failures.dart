import 'package:equatable/equatable.dart';

/// Classe de base pour les Failures
///
/// Les Failures représentent les erreurs métier retournées par les
/// Repositories via Either<Failure, Success>.
/// Contrairement aux Exceptions, elles sont typées et prévisibles.
sealed class Failure extends Equatable {
  const Failure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

/// Failure pour les erreurs serveur
class ServerFailure extends Failure {
  const ServerFailure({super.message, this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() =>
      message ?? 'Une erreur serveur est survenue. Veuillez réessayer.';
}

/// Failure pour les erreurs réseau
class NetworkFailure extends Failure {
  const NetworkFailure({super.message});

  @override
  String toString() =>
      message ?? 'Impossible de se connecter. Vérifiez votre connexion internet.';
}

/// Failure pour les erreurs d'authentification
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message});

  @override
  String toString() =>
      message ?? 'Session expirée. Veuillez vous reconnecter.';
}

/// Failure quand une ressource n'est pas trouvée
class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});

  @override
  String toString() =>
      message ?? 'Utilisateur non trouvé.';
}

/// Failure pour les erreurs de cache
class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  String toString() =>
      message ?? 'Erreur lors de la récupération des données en cache.';
}

/// Failure générique pour les erreurs inattendues
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message});

  @override
  String toString() =>
      message ?? 'Une erreur inattendue est survenue.';
}
