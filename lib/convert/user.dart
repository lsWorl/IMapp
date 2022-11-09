import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String name;
  final String phone;
  final String date;
  final String address;
  final String avatar;
  final String described;
  final String sex;
  final int user_id;
  final int contact_id;
  final String last_msg;
  final int msg_num;
  final String room_key;
  final String is_out;
  User(
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
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
