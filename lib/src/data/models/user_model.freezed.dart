// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PictureModel _$PictureModelFromJson(Map<String, dynamic> json) {
  return _PictureModel.fromJson(json);
}

/// @nodoc
mixin _$PictureModel {
  String get url => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  /// Serializes this PictureModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PictureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PictureModelCopyWith<PictureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PictureModelCopyWith<$Res> {
  factory $PictureModelCopyWith(
    PictureModel value,
    $Res Function(PictureModel) then,
  ) = _$PictureModelCopyWithImpl<$Res, PictureModel>;
  @useResult
  $Res call({String url, String label});
}

/// @nodoc
class _$PictureModelCopyWithImpl<$Res, $Val extends PictureModel>
    implements $PictureModelCopyWith<$Res> {
  _$PictureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PictureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? label = null}) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PictureModelImplCopyWith<$Res>
    implements $PictureModelCopyWith<$Res> {
  factory _$$PictureModelImplCopyWith(
    _$PictureModelImpl value,
    $Res Function(_$PictureModelImpl) then,
  ) = __$$PictureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String label});
}

/// @nodoc
class __$$PictureModelImplCopyWithImpl<$Res>
    extends _$PictureModelCopyWithImpl<$Res, _$PictureModelImpl>
    implements _$$PictureModelImplCopyWith<$Res> {
  __$$PictureModelImplCopyWithImpl(
    _$PictureModelImpl _value,
    $Res Function(_$PictureModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PictureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? label = null}) {
    return _then(
      _$PictureModelImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PictureModelImpl implements _PictureModel {
  const _$PictureModelImpl({required this.url, required this.label});

  factory _$PictureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PictureModelImplFromJson(json);

  @override
  final String url;
  @override
  final String label;

  @override
  String toString() {
    return 'PictureModel(url: $url, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PictureModelImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, label);

  /// Create a copy of PictureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PictureModelImplCopyWith<_$PictureModelImpl> get copyWith =>
      __$$PictureModelImplCopyWithImpl<_$PictureModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PictureModelImplToJson(this);
  }
}

abstract class _PictureModel implements PictureModel {
  const factory _PictureModel({
    required final String url,
    required final String label,
  }) = _$PictureModelImpl;

  factory _PictureModel.fromJson(Map<String, dynamic> json) =
      _$PictureModelImpl.fromJson;

  @override
  String get url;
  @override
  String get label;

  /// Create a copy of PictureModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PictureModelImplCopyWith<_$PictureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  /// Identifiant unique
  int get id => throw _privateConstructorUsedError;

  /// Prénom
  @JsonKey(name: 'first_name')
  String get firstName => throw _privateConstructorUsedError;

  /// Nom de famille
  @JsonKey(name: 'last_name')
  String get lastName => throw _privateConstructorUsedError;

  /// Liste des images de profil (différentes tailles)
  List<PictureModel> get picture => throw _privateConstructorUsedError;

  /// Email
  String? get email => throw _privateConstructorUsedError;

  /// Info/bio
  String? get info => throw _privateConstructorUsedError;

  /// Type de compte
  @JsonKey(name: 'account_type')
  String? get accountType => throw _privateConstructorUsedError;

  /// Points
  int get points => throw _privateConstructorUsedError;

  /// Nombre de badges
  @JsonKey(name: 'badges_count')
  int get badgesCount => throw _privateConstructorUsedError;

  /// Nombre de followers
  @JsonKey(name: 'followers_count')
  int get followersCount => throw _privateConstructorUsedError;

  /// Nombre de workouts
  @JsonKey(name: 'workouts_count')
  int get workoutsCount => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    List<PictureModel> picture,
    String? email,
    String? info,
    @JsonKey(name: 'account_type') String? accountType,
    int points,
    @JsonKey(name: 'badges_count') int badgesCount,
    @JsonKey(name: 'followers_count') int followersCount,
    @JsonKey(name: 'workouts_count') int workoutsCount,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? picture = null,
    Object? email = freezed,
    Object? info = freezed,
    Object? accountType = freezed,
    Object? points = null,
    Object? badgesCount = null,
    Object? followersCount = null,
    Object? workoutsCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            firstName: null == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String,
            lastName: null == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String,
            picture: null == picture
                ? _value.picture
                : picture // ignore: cast_nullable_to_non_nullable
                      as List<PictureModel>,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            info: freezed == info
                ? _value.info
                : info // ignore: cast_nullable_to_non_nullable
                      as String?,
            accountType: freezed == accountType
                ? _value.accountType
                : accountType // ignore: cast_nullable_to_non_nullable
                      as String?,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            badgesCount: null == badgesCount
                ? _value.badgesCount
                : badgesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            followersCount: null == followersCount
                ? _value.followersCount
                : followersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            workoutsCount: null == workoutsCount
                ? _value.workoutsCount
                : workoutsCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    @JsonKey(name: 'first_name') String firstName,
    @JsonKey(name: 'last_name') String lastName,
    List<PictureModel> picture,
    String? email,
    String? info,
    @JsonKey(name: 'account_type') String? accountType,
    int points,
    @JsonKey(name: 'badges_count') int badgesCount,
    @JsonKey(name: 'followers_count') int followersCount,
    @JsonKey(name: 'workouts_count') int workoutsCount,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? picture = null,
    Object? email = freezed,
    Object? info = freezed,
    Object? accountType = freezed,
    Object? points = null,
    Object? badgesCount = null,
    Object? followersCount = null,
    Object? workoutsCount = null,
  }) {
    return _then(
      _$UserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        firstName: null == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String,
        lastName: null == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String,
        picture: null == picture
            ? _value._picture
            : picture // ignore: cast_nullable_to_non_nullable
                  as List<PictureModel>,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        info: freezed == info
            ? _value.info
            : info // ignore: cast_nullable_to_non_nullable
                  as String?,
        accountType: freezed == accountType
            ? _value.accountType
            : accountType // ignore: cast_nullable_to_non_nullable
                  as String?,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        badgesCount: null == badgesCount
            ? _value.badgesCount
            : badgesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        followersCount: null == followersCount
            ? _value.followersCount
            : followersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        workoutsCount: null == workoutsCount
            ? _value.workoutsCount
            : workoutsCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl({
    required this.id,
    @JsonKey(name: 'first_name') required this.firstName,
    @JsonKey(name: 'last_name') required this.lastName,
    final List<PictureModel> picture = const [],
    this.email,
    this.info,
    @JsonKey(name: 'account_type') this.accountType,
    this.points = 0,
    @JsonKey(name: 'badges_count') this.badgesCount = 0,
    @JsonKey(name: 'followers_count') this.followersCount = 0,
    @JsonKey(name: 'workouts_count') this.workoutsCount = 0,
  }) : _picture = picture,
       super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  /// Identifiant unique
  @override
  final int id;

  /// Prénom
  @override
  @JsonKey(name: 'first_name')
  final String firstName;

  /// Nom de famille
  @override
  @JsonKey(name: 'last_name')
  final String lastName;

  /// Liste des images de profil (différentes tailles)
  final List<PictureModel> _picture;

  /// Liste des images de profil (différentes tailles)
  @override
  @JsonKey()
  List<PictureModel> get picture {
    if (_picture is EqualUnmodifiableListView) return _picture;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_picture);
  }

  /// Email
  @override
  final String? email;

  /// Info/bio
  @override
  final String? info;

  /// Type de compte
  @override
  @JsonKey(name: 'account_type')
  final String? accountType;

  /// Points
  @override
  @JsonKey()
  final int points;

  /// Nombre de badges
  @override
  @JsonKey(name: 'badges_count')
  final int badgesCount;

  /// Nombre de followers
  @override
  @JsonKey(name: 'followers_count')
  final int followersCount;

  /// Nombre de workouts
  @override
  @JsonKey(name: 'workouts_count')
  final int workoutsCount;

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, picture: $picture, email: $email, info: $info, accountType: $accountType, points: $points, badgesCount: $badgesCount, followersCount: $followersCount, workoutsCount: $workoutsCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            const DeepCollectionEquality().equals(other._picture, _picture) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.info, info) || other.info == info) &&
            (identical(other.accountType, accountType) ||
                other.accountType == accountType) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.badgesCount, badgesCount) ||
                other.badgesCount == badgesCount) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.workoutsCount, workoutsCount) ||
                other.workoutsCount == workoutsCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    firstName,
    lastName,
    const DeepCollectionEquality().hash(_picture),
    email,
    info,
    accountType,
    points,
    badgesCount,
    followersCount,
    workoutsCount,
  );

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel({
    required final int id,
    @JsonKey(name: 'first_name') required final String firstName,
    @JsonKey(name: 'last_name') required final String lastName,
    final List<PictureModel> picture,
    final String? email,
    final String? info,
    @JsonKey(name: 'account_type') final String? accountType,
    final int points,
    @JsonKey(name: 'badges_count') final int badgesCount,
    @JsonKey(name: 'followers_count') final int followersCount,
    @JsonKey(name: 'workouts_count') final int workoutsCount,
  }) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  /// Identifiant unique
  @override
  int get id;

  /// Prénom
  @override
  @JsonKey(name: 'first_name')
  String get firstName;

  /// Nom de famille
  @override
  @JsonKey(name: 'last_name')
  String get lastName;

  /// Liste des images de profil (différentes tailles)
  @override
  List<PictureModel> get picture;

  /// Email
  @override
  String? get email;

  /// Info/bio
  @override
  String? get info;

  /// Type de compte
  @override
  @JsonKey(name: 'account_type')
  String? get accountType;

  /// Points
  @override
  int get points;

  /// Nombre de badges
  @override
  @JsonKey(name: 'badges_count')
  int get badgesCount;

  /// Nombre de followers
  @override
  @JsonKey(name: 'followers_count')
  int get followersCount;

  /// Nombre de workouts
  @override
  @JsonKey(name: 'workouts_count')
  int get workoutsCount;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
