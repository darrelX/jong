import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/auth/data/models/user_model.dart';
import 'package:jong/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationRepository {
  final Dio dio;
  final Future<SharedPreferences> prefs;

  ApplicationRepository()
      : dio = getIt.get<Dio>(),
        prefs = getIt.get<Future<SharedPreferences>>();

  deposit(
      {required String method,
      required int amount,
      required int userId,
      required String phoneNumber}) async {
    try {
      final response = await dio.post('/deposits', data: {
        "method": method,
        "amount": amount,
        "user_id": userId,
        "phone_number": phoneNumber
      });
      return response.data as Map<String, dynamic>;
    } catch (e) {
      rethrow;
    }
  }

  getStatusTransaction({required int userId}) async {
    final Response response = await dio.get('/deposits',
        options: Options(headers: {"user_id": userId}));
    //  DepositModel.fromJson(response.data["data"], response.data["total"]);
  }

  Future<UserModel?> getUser(String token) async {
    SharedPreferences storage = await prefs;
    String? token = storage.getString('token');

    try {
      Response response = await dio.get(
        '/auth/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      log(response.data.toString());
      return UserModel.fromJson(response.data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
