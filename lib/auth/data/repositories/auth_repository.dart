import 'dart:developer';

import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthRepository {
  final Dio dio;
  AuthRepository({
    required this.dio,
  });

  Future<UserModel> getUser() async {
    Response response = await dio.get('/user/');
    return UserModel.fromJson(response.data);
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    Response response = await dio.post(
      '/login/',
      data: {
        "email": email,
        "password": password,
      },
    );
    print(response.toString());
    print("ök");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', response.data['token']);
    return await getUser();
  }

  Future<UserModel> register({
    required String username,
    required String email,
    required DateTime birthDate,
    required int gender,
    required String phone,
    required String password,
  }) async {
    Response response = await dio.post(
      '/register/',
      data: {
        "username": username,
        "password": password,
        "email": email,
        // "birthDate": birthDate.toIso8601String(),
        "gender": gender,
        "phone": phone,
      },
    );

    log(response.data.toString());
    return await login(
      email: email,
      password: password,
    );
  }
}
