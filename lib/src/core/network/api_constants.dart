/// Constantes pour l'API AZEOO
abstract class ApiConstants {
  ApiConstants._();

  /// URL de base de l'API
  static const String baseUrl = 'https://api.azeoo.dev/v1';

  /// Token d'authentification Bearer
  static const String bearerToken =
      'api_474758da8532e795f63bc4e5e6beca7298379993f65bb861f2e8e13c352cc'
      '4dcebcc3b10961a5c369edb05fbc0b0053cf63df1c53d9ddd7e4e5d680beb514d20';

  /// Endpoints
  static const String usersMe = '/users/me';

  /// Headers par défaut
  static const String acceptLanguage = 'fr-FR';

  /// Timeout en millisecondes
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
}
