import 'package:json_annotation/json_annotation.dart';

part 'user_contacts.g.dart';

// explicitToJson开启内部json转换
@JsonSerializable(explicitToJson: true)
class UserContacts {
  final String name;
  final String phone;
  final String date;
  final String address;
  final String avatar;
  final String described;
  final String sex;
  final int? user_id;
  final int? contact_id;
  final String? last_msg;
  final int? msg_num;
  final String? room_key;
  final String? is_out;
  UserContacts(
      this.name,
      this.phone,
      this.date,
      this.address,
      this.avatar,
      this.described,
      this.sex,
      this.user_id,
      this.contact_id,
      this.last_msg,
      this.msg_num,
      this.room_key,
      this.is_out);
  factory UserContacts.fromJson(Map<String, dynamic> json) =>
      _$UserContactsFromJson(json);
  Map<String, dynamic> toJson() => _$UserContactsToJson(this);
}
