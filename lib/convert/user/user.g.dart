// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      json['name'] as String,
      json['phone'] as String,
      json['date'] as String,
      json['address'] as String,
      json['avatar'] as String,
      json['described'] as String,
      json['sex'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'date': instance.date,
      'address': instance.address,
      'avatar': instance.avatar,
      'described': instance.described,
      'sex': instance.sex,
    };
