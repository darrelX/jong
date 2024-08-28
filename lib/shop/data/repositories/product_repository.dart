import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shop/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  final Dio dio;
  Future<SharedPreferences>? prefs;

  ProductRepository()
      : dio = getIt.get<Dio>(),
        prefs = getIt.get<Future<SharedPreferences>>();

  Future<List<ProductModel>> fetchProductsList(int userId) async {
    try {
      Response response =
          await dio.get('/products', queryParameters: {"user_id": userId});
      List<dynamic> productsJson = response.data['data'] as List<dynamic>;

      List<ProductModel> products = productsJson.map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('An error occurred: $e');
      rethrow;
    }
  }

  Future<bool> createTicket(Map<String, dynamic> json, int userId) async {
    try {
      Response response = await dio.post('/tickets',
          queryParameters: {"user_id": userId}, data: json);
      log(response.data.toString());
      if (response.data["status"]) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('An error occurred: $e');

      rethrow;
    }
  }
}
