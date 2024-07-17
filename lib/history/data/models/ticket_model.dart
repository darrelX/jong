class TicketModel {
  final String? id;
  final String? userId;
  final int? totalAmount;
  final bool? status;
  final DateTime? createdAt; // New property
  final DateTime? updatedAt;
  final List<Map<String, dynamic>>? products;

  TicketModel(
      {required this.id,
      required this.totalAmount,
      required this.userId,
      this.status = false,
      required this.createdAt,
      this.updatedAt,
      required this.products});

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
        id: (json['id'] as int).toString() as String?,
        totalAmount: json['total_amount'] as int?,
        userId: (json['user_id'] as int).toString() as String?,
        status: json['status'] as bool?,
        createdAt: (json['created_at'] as String) as DateTime?,
        updatedAt: (json['updated_at'] as String) as DateTime?,
        products: json['products'] as List<Map<String, dynamic>>?);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'user_id': userId,
        'quantity': totalAmount,
        'status': status,
        'created_At': createdAt,
        'products': products
      };


}
