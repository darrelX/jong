import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthRepository {
  final Dio dio;
  final Future<SharedPreferences>? prefs;

  AuthRepository({
    required this.dio,
    this.prefs,
  });

  Future<UserModel?> getUser(String phone) async {
    SharedPreferences storage = await prefs!;
    String? token = storage.getString('token');

    try {
      Response response = await dio.get(
        '/users',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {'phone_number': phone},
      );
      return UserModel.fromJson(response.data['data'][0]);
    } catch (error) {
      print(
          "Une erreur s'est produite lors de la récupération de l'utilisateur : $error");
      return null;
    }
  }

  Future<UserModel?> login({
    required String phone,
    required String password,
  }) async {
    SharedPreferences storage = await prefs!;
    // final String token;

    Response response = await dio.post(
      '/auth/login',
      data: {
        "phone_number": phone,
        "password": password,
      },
    );

    // print(response.data);
    if (response.data != null) {
      storage.setString('token', response.data['token'] ?? '');
    }
    // token = storage.getString('token') ?? '';

    return getUser(phone);
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
