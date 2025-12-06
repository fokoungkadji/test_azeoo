import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class PictureModel with _$PictureModel {
  const factory PictureModel({
    required String url,
    required String label,
  }) = _PictureModel;

  factory PictureModel.fromJson(Map<String, dynamic> json) =>
      _$PictureModelFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,

    @JsonKey(name: 'first_name') required String firstName,

    @JsonKey(name: 'last_name') required String lastName,

    @Default([]) List<PictureModel> picture,

    String? email,

    String? info,

    @JsonKey(name: 'account_type') String? accountType,

    @Default(0) int points,

    @JsonKey(name: 'badges_count') @Default(0) int badgesCount,

    @JsonKey(name: 'followers_count') @Default(0) int followersCount,

    @JsonKey(name: 'workouts_count') @Default(0) int workoutsCount,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  String? get avatarUrl {
    if (picture.isEmpty) return null;

    final smallPicture = picture.where((p) => p.label == 'small').firstOrNull;
    if (smallPicture != null) return smallPicture.url;

    final thumbPicture =
        picture.where((p) => p.label == 'thumbnail').firstOrNull;
    if (thumbPicture != null) return thumbPicture.url;

    return picture.first.url;
  }

  User toEntity() => User(
        id: id.toString(),
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
        email: email,
      );
}

extension UserModelFromEntity on User {
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
