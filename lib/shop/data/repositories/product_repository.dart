import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/shop/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository {
  final Dio dio;
  SharedPreferences? prefs;

  ProductRepository({
    required this.dio,
    this.prefs,
  });

  Future<void> products(Map<String, dynamic> product) async {
    try {
      // Prepare request data
      final requestData = {
        'token': prefs!.getString('token'),
        'total_price': product['total_price'],
        'items': [...product['items']]
      };

      Response response = await dio.post('/products', data: requestData);

      if (response.statusCode == 200) {
        // Request successful
        print('Product data successfully recorded.');
      } else {
        // Request failed
        print(
            'Failed to record product data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
