// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'email', 'balance', 'phone_number'],
  );
  return UserModel(
    id: json['id'] as int?,
    name: json['name'] as String? ?? '',
    email: json['email'] as String? ?? '',
    balance: json['balance'] as String? ?? '',
    phoneNumber: json['phone_number'] as String? ?? '',
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'balance': instance.balance,
      'phone_number': instance.phoneNumber,
    };
