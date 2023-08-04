
import 'package:json_annotation/json_annotation.dart';

import 'UserModel.dart';

part 'DataModel.g.dart';

@JsonSerializable()
class DataModel {
  DataModel(this.error,this.data);
  UserModel data;
  String? error;

  factory DataModel.fromJson(Map<String,dynamic>json) => _$DataModelFromJson(json);
  Map<String,dynamic>toJson() => _$DataModelToJson(this);
}