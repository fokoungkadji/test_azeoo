/// Exceptions personnalisées pour le SDK AZEOO
///
/// Ces exceptions sont levées par les DataSources et converties
/// en Failures par les Repositories.

/// Exception levée lors d'une erreur serveur (5xx)
class ServerException implements Exception {
  const ServerException({this.message, this.statusCode});

  final String? message;
  final int? statusCode;

  @override
  String toString() =>
      'ServerException: ${message ?? 'Une erreur serveur est survenue'} '
      '(code: $statusCode)';
}

/// Exception levée lors d'une erreur réseau
class NetworkException implements Exception {
  const NetworkException({this.message});

  final String? message;

  @override
  String toString() =>
      'NetworkException: ${message ?? 'Erreur de connexion réseau'}';
}

/// Exception levée lors d'une erreur d'authentification (401, 403)
class UnauthorizedException implements Exception {
  const UnauthorizedException({this.message});

  final String? message;

  @override
  String toString() =>
      'UnauthorizedException: ${message ?? 'Non autorisé'}';
}

/// Exception levée quand une ressource n'est pas trouvée (404)
class NotFoundException implements Exception {
  const NotFoundException({this.message});

  final String? message;

  @override
  String toString() =>
      'NotFoundException: ${message ?? 'Ressource non trouvée'}';
}

/// Exception levée lors d'une erreur de cache
class CacheException implements Exception {
  const CacheException({this.message});

  final String? message;

  @override
  String toString() =>
      'CacheException: ${message ?? 'Erreur de cache'}';
}

/// Exception levée lors d'une erreur de parsing/sérialisation
class ParsingException implements Exception {
  const ParsingException({this.message});

  final String? message;

  @override
  String toString() =>
      'ParsingException: ${message ?? 'Erreur de parsing des données'}';
}
