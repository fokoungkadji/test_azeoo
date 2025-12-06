import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Modèle pour une image de profil
@freezed
class PictureModel with _$PictureModel {
  const factory PictureModel({
    required String url,
    required String label,
  }) = _PictureModel;

  factory PictureModel.fromJson(Map<String, dynamic> json) =>
      _$PictureModelFromJson(json);
}

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

    /// Liste des images de profil (différentes tailles)
    @Default([]) List<PictureModel> picture,

    /// Email
    String? email,

    /// Info/bio
    String? info,

    /// Type de compte
    @JsonKey(name: 'account_type') String? accountType,

    /// Points
    @Default(0) int points,

    /// Nombre de badges
    @JsonKey(name: 'badges_count') @Default(0) int badgesCount,

    /// Nombre de followers
    @JsonKey(name: 'followers_count') @Default(0) int followersCount,

    /// Nombre de workouts
    @JsonKey(name: 'workouts_count') @Default(0) int workoutsCount,
  }) = _UserModel;

  const UserModel._();

  /// Crée un UserModel depuis un JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Récupère l'URL de l'avatar (préfère 'small', sinon 'thumbnail', sinon première image)
  String? get avatarUrl {
    if (picture.isEmpty) return null;

    // Chercher l'image "small" en priorité
    final smallPicture = picture.where((p) => p.label == 'small').firstOrNull;
    if (smallPicture != null) return smallPicture.url;

    // Sinon "thumbnail"
    final thumbPicture =
        picture.where((p) => p.label == 'thumbnail').firstOrNull;
    if (thumbPicture != null) return thumbPicture.url;

    // Sinon la première image disponible
    return picture.first.url;
  }

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
        picture: avatarUrl != null
            ? [PictureModel(url: avatarUrl!, label: 'small')]
            : [],
        email: email,
      );
}
