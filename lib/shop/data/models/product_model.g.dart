// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  // print('babadi ${json['id']}');
  return ProductModel(
    id: (json['id']).toString() as String?,
    name: json['name'] as String?,
    createdAt: DateTime.parse(json['created_at'] as String) as DateTime?,
    productCategoryId: json['product_category_id'] as int?,
    price: double.parse(json['price'] as String) as double?,
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'product_category_id': instance.productCategoryId,
      'price': instance.price,
    };
