import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(required: true)
  final int? id;
  @JsonKey(required: true)
  final String? name;
  @JsonKey(required: true)
  final String? email;
  @JsonKey(required: true)
  final double? balance;
  @JsonKey(required: true)
  final String? phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
    required this.phoneNumber,
  });

    UserModel copyWith({
    int? id,
    String? name,
    String? email,
    double? balance,
   String? phoneNumber

  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
