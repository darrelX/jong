class UserModel {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String solde;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.solde,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      solde: json['solde'],
    );
  }
}
