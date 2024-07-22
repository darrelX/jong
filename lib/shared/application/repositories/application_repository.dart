import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationRepository {
  final Dio dio;
  final Future<SharedPreferences> prefs;

  ApplicationRepository()
      : dio = getIt.get<Dio>(),
        prefs = getIt.get<Future<SharedPreferences>>();

  deposit({required String method,required int amount, required int userId}) async {
    try {
      final response = await dio.post('/deposits',
          data: {"method": method, "amount": amount, "user_id": userId});
      final Map<String, dynamic> deposit = response.data;
      print('deposit $deposit');
      return deposit['amount'];
    } catch (e) {
      log(e.toString());
      print(e);
      rethrow;
    }
  }
}
