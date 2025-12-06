
class ServerException implements Exception {
  const ServerException({this.message, this.statusCode});

  final String? message;
  final int? statusCode;

  @override
  String toString() =>
      'ServerException: ${message ?? 'Une erreur serveur est survenue'} '
      '(code: $statusCode)';
}

class NetworkException implements Exception {
  const NetworkException({this.message});

  final String? message;

  @override
  String toString() =>
      'NetworkException: ${message ?? 'Erreur de connexion réseau'}';
}

class UnauthorizedException implements Exception {
  const UnauthorizedException({this.message});

  final String? message;

  @override
  String toString() =>
      'UnauthorizedException: ${message ?? 'Non autorisé'}';
}

class NotFoundException implements Exception {
  const NotFoundException({this.message});

  final String? message;

  @override
  String toString() =>
      'NotFoundException: ${message ?? 'Ressource non trouvée'}';
}

class CacheException implements Exception {
  const CacheException({this.message});

  final String? message;

  @override
  String toString() =>
      'CacheException: ${message ?? 'Erreur de cache'}';
}

class ParsingException implements Exception {
  const ParsingException({this.message});

  final String? message;

  @override
  String toString() =>
      'ParsingException: ${message ?? 'Erreur de parsing des données'}';
}
