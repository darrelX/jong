import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true)
  final String email;
  // @JsonKey(required: true)
  final String balance;


  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
      
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  String toJsonString() {
    return json.encode(toJson());
  }

  factory UserModel.fromJsonString(String jsonString) {
    final jsonData = json.decode(jsonString);
    return UserModel.fromJson(jsonData);
  }
}
