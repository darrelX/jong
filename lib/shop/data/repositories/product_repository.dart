import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/shop/data/models/product_model.dart';
import 'package:jong/shop/logic/product_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  final Dio dio;
  Future<SharedPreferences>? prefs;

  ProductRepository({
    required this.dio,
    this.prefs,
  });

  Future<ProductModel?> fetchProduct() async {
    try {
      Response response = await dio.get(
        '/products',
      );
      return ProductModel.fromJson(response.data);
    } catch (e) {
      print('An error occurred: $e');
      return null; // Retourne null en cas d'erreur
    }
  }

  Future<List<ProductModel>> fetchProductsList() async {
    try {
      Response response = await dio.get('/products');
      var productsJson = response.data['data'] as List<dynamic>;

      List<ProductModel> products = productsJson.map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return products;
    } catch (e) {
      print('An error occurred: $e');
      return [];
    }
  }

  // createTicket(String token) async {
  //   final List basketItems = _articles['items']
  //       .where((article) =>
  //           _counters.containsKey(article['id']) &&
  //           _counters[article['id']]! > 0)
  //       .map((article) => {
  //             'id': article['id'],
  //             'quantity': _counters[article['id']],
  //           })
  //       .toList();

  //   return {
  //     'user_id': token,
  //     'products': basketItems,
  //   };
  // }
}
