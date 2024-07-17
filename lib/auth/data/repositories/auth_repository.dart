import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/shared/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthRepository {
  final Dio dio;
  final Future<SharedPreferences>? prefs;

  AuthRepository({
    required this.dio,
    this.prefs,
  });

  Future<UserModel?> getUser(String token) async {
    SharedPreferences storage = await prefs!;
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
      return null;
    }
  }

  Future<UserModel?> login({
    required String phone,
    required String password,
  }) async {
    SharedPreferences storage = await prefs!;
    final String token;

    Response response = await dio.post(
      '/auth/login',
      data: {
        "phone_number": phone,
        "password": password,
      },
    );

    if (response.data != null) {
      storage.setString('token', response.data['token'] ?? '');
    }
    token = storage.getString('token') ?? '';

    return getUser(token);
  }

  Future<UserModel?> register({
    required String username,
    required String email,
    required DateTime birthDate,
    required int gender,
    required String phone,
    required String password,
  }) async {
    final Response response = await dio.post(
      '/auth/register',
      data: {
        "name": username,
        "password": password,
        // "email": email,
        // "birthDate": birthDate.toIso8601String(),
        // "gender": gender,
        "phone_number": phone,
      },
    );

    log(response.data.toString());
    await login(
      phone: phone,
      password: password,
    );
    return getUser(phone);
  }
}
