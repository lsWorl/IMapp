import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String phone;
  final String date;
  final String address;
  final String avatar;
  final String described;
  final String sex;
  User(this.id, this.name, this.phone, this.date, this.address, this.avatar,
      this.described, this.sex);
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
