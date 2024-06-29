// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'username', 'email'],
  );
  return UserModel(
    id: json['id'] as String,
    name: json['username'] as String,
    email: json['email'] as String,
    balance: json['balance'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.name,
      'email': instance.email,
      'balance': instance.balance,
    };
