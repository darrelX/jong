import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String? id;
  final String? name;
  final int? productCategoryId;
  final double? price;
  final String? createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.productCategoryId,
    required this.price,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  String toJsonString() {
    return json.encode(toJson());
  }

  factory ProductModel.fromJsonString(String jsonString) {
    final jsonData = json.decode(jsonString);
    return ProductModel.fromJson(jsonData);
  }
}
