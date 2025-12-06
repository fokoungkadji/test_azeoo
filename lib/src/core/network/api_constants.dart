abstract class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.azeoo.dev/v1';

  static const String bearerToken =
      'api_474758da8532e795f63bc4e5e6beca7298379993f65bb861f2e8e13c352cc'
      '4dcebcc3b10961a5c369edb05fbc0b0053cf63df1c53d9ddd7e4e5d680beb514d20';

  static const String usersMe = '/users/me';

  static const String acceptLanguage = 'fr-FR';

  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;
}
