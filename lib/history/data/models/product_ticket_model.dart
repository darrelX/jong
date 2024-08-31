class ProductTicketModel {
  final String? id;
  final String? name;
  final double? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? quantity;
  final String? productCategoryId;
  final int? total;

  const ProductTicketModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.createdAt,
      required this.updatedAt,
      required this.quantity,
      this.total,
      required this.productCategoryId});

  factory ProductTicketModel.fromJson(Map<String, dynamic> json) {
    return ProductTicketModel(
      id: (json['id'] as int).toString() as String?,
      price: double.parse(json['price'] as String) as double?,
      quantity: json['quantity'] as int?,
      name: json['name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String) as DateTime?,
      updatedAt: DateTime.parse(json['updated_at'] as String) as DateTime?,
      productCategoryId:
          (json['product_category_id'] as int).toString() as String?,
    );
  }

  // Map<String, dynamic> toJson() => <String, dynamic>{
  //       'id': id,
  //       'user_id': userId,
  //       'quantity': totalAmount,
  //       'status': status,
  //       'created_At': createdAt,
  //       'products': products
  //     };
}
