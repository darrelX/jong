import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository{
    final Dio dio;
  SharedPreferences? prefs;

  ProductRepository({
    required this.dio,
    this.prefs,
  });

  

}