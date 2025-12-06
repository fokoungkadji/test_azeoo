import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_constants.dart';
import '../models/user_model.dart';

/// Interface pour la source de données distante des utilisateurs
abstract class UserRemoteDataSource {
  /// Récupère le profil utilisateur depuis l'API
  ///
  /// [userId] L'identifiant de l'utilisateur
  ///
  /// Throws [ServerException] en cas d'erreur serveur
  /// Throws [NetworkException] en cas d'erreur réseau
  /// Throws [NotFoundException] si l'utilisateur n'existe pas
  Future<UserModel> getUserProfile(String userId);
}

/// Implémentation de la source de données distante
@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<UserModel> getUserProfile(String userId) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        ApiConstants.usersMe,
        headers: {
          'X-User-Id': userId,
        },
      );

      final data = response.data;

      if (data == null) {
        throw const ServerException(message: 'Réponse vide du serveur');
      }

      // L'API peut retourner les données directement ou dans un champ "data"
      final userData = data['data'] as Map<String, dynamic>? ?? data;

      return UserModel.fromJson(userData);
    } on DioException catch (e) {
      // L'erreur a déjà été transformée par l'intercepteur
      if (e.error is Exception) {
        throw e.error as Exception;
      }
      throw ServerException(message: e.message);
    } on FormatException catch (e) {
      throw ParsingException(message: 'Erreur de parsing: ${e.message}');
    }
  }
}
