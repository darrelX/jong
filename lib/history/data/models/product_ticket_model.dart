class ProductTicketModel {
  final String? id;
  final String? name;
  final int? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? quantity;
  final String? productCategoryId;

  const ProductTicketModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.createdAt,
      required this.updatedAt,
      required this.quantity,
      required this.productCategoryId});

  factory ProductTicketModel.fromJson(Map<String, dynamic> json) {
    return ProductTicketModel(
      id: (json['id'] as int).toString() as String?,
      price: int.parse(json['price'] as String) as int?,
      quantity: json['quantity'] as int?,
      name: json['name'] as String?,
      createdAt: (json['created_at'] as String) as DateTime?,
      updatedAt: (json['updated_at'] as String) as DateTime?,
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
