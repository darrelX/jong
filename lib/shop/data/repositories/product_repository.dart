import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shop/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  final Dio dio;
  final Future<SharedPreferences>? prefs;
  // int _page = 1;

  ProductRepository()
      : dio = getIt.get<Dio>(),
        prefs = getIt.get<Future<SharedPreferences>>();

  Future<ProductModels> fetchProductsList(int userId) async {
    try {
      List<ProductModel> products = [];
      Response response = await dio
          .get('/products', queryParameters: {"user_id": userId, "page": 1});
      List<dynamic> productsJson = response.data['data'] as List<dynamic>;
      int totalPage = response.data['total'] as int;

      products.addAll(productsJson.map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList());
      if (totalPage > 1) {
        for (int page = 2; page <= totalPage; page++) {
          response = await dio.get('/products',
              queryParameters: {"user_id": userId, "page": page});
          productsJson = response.data['data'] as List<dynamic>;

          products.addAll(productsJson.map((item) {
            return ProductModel.fromJson(item as Map<String, dynamic>);
          }).toList());
        }
      }

      return ProductModels.fromJson(products, totalPage);
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
