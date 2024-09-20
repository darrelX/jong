class ProductModel {
  final String? id;
  final String? name;
  final int? productCategoryId;
  final double? price;
  final DateTime? createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.productCategoryId,
    required this.price,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString() as String?,
      name: json['name'] as String?,
      productCategoryId: json['product_category_id'] as int?,
      price: double.parse(json['price'].toString()) as double?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'].toString()),
    );
  }

  // Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

class ProductModels {
  final List<ProductModel> list;
  final int total;

  const ProductModels({required this.list, required this.total});

  factory ProductModels.fromJson(List<ProductModel> list, int total) {
    return ProductModels(list: list, total: total);
  }
}
