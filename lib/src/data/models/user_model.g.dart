// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PictureModelImpl _$$PictureModelImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(r'_$PictureModelImpl', json, ($checkedConvert) {
      final val = _$PictureModelImpl(
        url: $checkedConvert('url', (v) => v as String),
        label: $checkedConvert('label', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$$PictureModelImplToJson(_$PictureModelImpl instance) =>
    <String, dynamic>{'url': instance.url, 'label': instance.label};

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$UserModelImpl',
      json,
      ($checkedConvert) {
        final val = _$UserModelImpl(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          firstName: $checkedConvert('first_name', (v) => v as String),
          lastName: $checkedConvert('last_name', (v) => v as String),
          picture: $checkedConvert(
            'picture',
            (v) =>
                (v as List<dynamic>?)
                    ?.map(
                      (e) => PictureModel.fromJson(e as Map<String, dynamic>),
                    )
                    .toList() ??
                const [],
          ),
          email: $checkedConvert('email', (v) => v as String?),
          info: $checkedConvert('info', (v) => v as String?),
          accountType: $checkedConvert('account_type', (v) => v as String?),
          points: $checkedConvert('points', (v) => (v as num?)?.toInt() ?? 0),
          badgesCount: $checkedConvert(
            'badges_count',
            (v) => (v as num?)?.toInt() ?? 0,
          ),
          followersCount: $checkedConvert(
            'followers_count',
            (v) => (v as num?)?.toInt() ?? 0,
          ),
          workoutsCount: $checkedConvert(
            'workouts_count',
            (v) => (v as num?)?.toInt() ?? 0,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'firstName': 'first_name',
        'lastName': 'last_name',
        'accountType': 'account_type',
        'badgesCount': 'badges_count',
        'followersCount': 'followers_count',
        'workoutsCount': 'workouts_count',
      },
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'picture': instance.picture.map((e) => e.toJson()).toList(),
      if (instance.email case final value?) 'email': value,
      if (instance.info case final value?) 'info': value,
      if (instance.accountType case final value?) 'account_type': value,
      'points': instance.points,
      'badges_count': instance.badgesCount,
      'followers_count': instance.followersCount,
      'workouts_count': instance.workoutsCount,
    };
