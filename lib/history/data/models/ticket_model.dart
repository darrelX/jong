class TicketModel {
  final String id;
  final String userId;
  final int quantity;
  final bool status;
  final DateTime? createdAt; // New property
  final DateTime? updatedAt;

  TicketModel({
    required this.id,
    required this.quantity,
    required this.userId,
    this.status = false,
    required this.createdAt,
    this.updatedAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String,
      quantity: json['id'] as int,
      userId: json['id'] as String,
      createdAt: json['id'] as DateTime,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
      'id': id,
      'user_id': userId,
      'quantity': quantity,
      'status': status,
      'created_At' : createdAt
    };
}
