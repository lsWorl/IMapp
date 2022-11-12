// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_contacts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserContacts _$UserContactsFromJson(Map<String, dynamic> json) => UserContacts(
      json['name'] as String,
      json['phone'] as String,
      json['date'] as String,
      json['address'] as String,
      json['avatar'] as String,
      json['described'] as String,
      json['sex'] as String,
      json['user_id'] as int?,
      json['contact_id'] as int?,
      json['last_msg'] as String?,
      json['msg_num'] as int?,
      json['room_key'] as String?,
      json['is_out'] as String?,
    );

Map<String, dynamic> _$UserContactsToJson(UserContacts instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'date': instance.date,
      'address': instance.address,
      'avatar': instance.avatar,
      'described': instance.described,
      'sex': instance.sex,
      'user_id': instance.user_id,
      'contact_id': instance.contact_id,
      'last_msg': instance.last_msg,
      'msg_num': instance.msg_num,
      'room_key': instance.room_key,
      'is_out': instance.is_out,
    };
