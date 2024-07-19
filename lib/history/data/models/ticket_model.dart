import 'package:jong/history/data/models/product_ticket_model.dart';
import 'package:jong/history/presentation/widgets/products_of_ticket.dart';

class TicketModel {
  final String? id;
  final String? userId;
  final double? totalAmount;
  final bool? status;
  final DateTime? createdAt; // New property
  final DateTime? updatedAt;
  final List<ProductTicketModel>? products;

  TicketModel({
    required this.id,
    required this.totalAmount,
    required this.userId,
    this.status = false,
    required this.createdAt,
    this.updatedAt,
    required this.products
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    // print("dada ${json['total_amount'].runtimeType} ${json['total_amount']}");
    return TicketModel(
      id: (json['id'] as int).toString() as String?,
      totalAmount: double.parse(json['total_amount'] as String) ,
      userId: (json['user_id'] as int).toString() as String?,
      status: json['status'] as bool?,
      createdAt: DateTime.parse(json['created_at'] as String) as DateTime?,
      updatedAt: DateTime.parse(json['updated_at'] as String) as DateTime?,
      products: fetchProductTicketList(json['products'])
      //     as List<ProductTicketModel>?);
    );
  }

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'id': id,
  //       'user_id': userId,
  //       // 'quantity': totalAmount,
  //       'status': status,
  //       'created_At': createdAt,
  //       'products': products
  //     };
}

List<ProductTicketModel> fetchProductTicketList(List<dynamic> json) {
  print(json);
  return json
      .map((item) => ProductTicketModel.fromJson(item as Map<String, dynamic>))
      .toList();
}
