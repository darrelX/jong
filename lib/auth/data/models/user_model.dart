class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final double? balance;
  final String? phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
    required this.phoneNumber,
  });

  UserModel copyWith(
      {int? id,
      String? name,
      String? email,
      double? balance,
      String? phoneNumber}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.parse(json['id'].toString()) as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      balance: double.parse(json['balance'].toString()) as double?,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  // Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
