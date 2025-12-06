import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message, this.statusCode});

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];

  @override
  String toString() =>
      message ?? 'Une erreur serveur est survenue. Veuillez réessayer.';
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message});

  @override
  String toString() =>
      message ?? 'Impossible de se connecter. Vérifiez votre connexion internet.';
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message});

  @override
  String toString() =>
      message ?? 'Session expirée. Veuillez vous reconnecter.';
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message});

  @override
  String toString() =>
      message ?? 'Utilisateur non trouvé.';
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});

  @override
  String toString() =>
      message ?? 'Erreur lors de la récupération des données en cache.';
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message});

  @override
  String toString() =>
      message ?? 'Une erreur inattendue est survenue.';
}
