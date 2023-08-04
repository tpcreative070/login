

import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel {
  String message;
  String username;
  String token;
  UserModel(this.username,this.token,this.message);

  factory UserModel.fromJson(Map<String,dynamic>json) => _$UserModelFromJson(json);
  Map<String,dynamic>toJson() => _$UserModelToJson(this);
}