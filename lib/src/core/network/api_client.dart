import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../error/exceptions.dart';
import 'api_constants.dart';

@lazySingleton
class ApiClient {
  ApiClient() : _dio = Dio(_baseOptions) {
    _dio.interceptors.addAll([
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);
  }

  final Dio _dio;

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
    receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
    sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Language': ApiConstants.acceptLanguage,
      'Authorization': 'Bearer ${ApiConstants.bearerToken}',
    },
  );

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } on DioException {
      rethrow;
    }
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioExceptionToCustomException(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
        type: err.type,
      ),
    );
  }

  Exception _mapDioExceptionToCustomException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(
          message: 'La connexion a expiré. Veuillez réessayer.',
        );

      case DioExceptionType.connectionError:
        return const NetworkException(
          message: 'Impossible de se connecter au serveur.',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return const NetworkException(
          message: 'La requête a été annulée.',
        );

      case DioExceptionType.badCertificate:
        return const NetworkException(
          message: 'Certificat SSL invalide.',
        );

      case DioExceptionType.unknown:
        if (error.error != null && error.error is Exception) {
          return error.error! as Exception;
        }
        return const NetworkException(
          message: 'Une erreur réseau est survenue.',
        );
    }
  }

  Exception _handleBadResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode;

    if (statusCode == null) {
      return const ServerException(message: 'Réponse invalide du serveur.');
    }

    switch (statusCode) {
      case 400:
        return ServerException(
          message: 'Requête invalide.',
          statusCode: statusCode,
        );
      case 401:
        return const UnauthorizedException(
          message: 'Non autorisé. Veuillez vous reconnecter.',
        );
      case 403:
        return const UnauthorizedException(
          message: 'Accès refusé.',
        );
      case 404:
        return const NotFoundException(
          message: 'Ressource non trouvée.',
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException(
          message: 'Erreur serveur. Veuillez réessayer plus tard.',
          statusCode: statusCode,
        );
      default:
        return ServerException(
          message: 'Erreur inattendue.',
          statusCode: statusCode,
        );
    }
  }
}
