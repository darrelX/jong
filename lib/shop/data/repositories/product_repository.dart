import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/shop/data/models/product_model.dart';
import 'package:jong/shop/logic/courter_model.dart';
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

      Response response = await dio.post('/products',
          data: CounterModel().getBasketItems(prefs!.getString('token')!));
    } catch (e) {
      print('An error occurred: $e');
    }
  }
}
