import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Modèle de données pour un utilisateur (DTO)
///
/// Cette classe représente la structure des données telles qu'elles
/// sont reçues de l'API et peut être convertie en entité User.
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    /// Identifiant unique
    required int id,

    /// Prénom
    @JsonKey(name: 'first_name') required String firstName,

    /// Nom de famille
    @JsonKey(name: 'last_name') required String lastName,

    /// URL de l'avatar
    @JsonKey(name: 'avatar_url') String? avatarUrl,

    /// Email
    String? email,
  }) = _UserModel;

  const UserModel._();

  /// Crée un UserModel depuis un JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convertit le modèle en entité User
  User toEntity() => User(
        id: id.toString(),
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
        email: email,
      );
}

/// Extension pour créer un UserModel depuis une entité User
extension UserModelFromEntity on User {
  /// Convertit une entité User en UserModel
  UserModel toModel() => UserModel(
        id: int.tryParse(id) ?? 0,
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
        email: email,
      );
}
