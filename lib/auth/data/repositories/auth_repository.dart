import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthRepository {
  final Dio dio;
  SharedPreferences? prefs;

  AuthRepository({
    required this.dio,
    this.prefs,
  });

  Future<UserModel?> getUser() async {
    String? token = prefs?.getString('token');
    try {
      Response response = await dio.get('/users/',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception(
            'Erreur lors de la récupération des informations utilisateur');
      }
    } catch (e) {
      print(e);
    }
    return null;
    // Utiliser la valeur du Shared Preferences
    // Faites quelque chose avec le token
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    Response response = await dio.post(
      '/login',
      data: {
        "email": email,
        "password": password,
      },
    );

    // print(response.data);
    if (response.data != null) {
      prefs?.setString('token', response.data['token']);
    } else {
      prefs?.remove('token');
    }
    return null;
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
      '/register',
      data: {
        "name": username,
        "password": password,
        "email": email,
        // "birthDate": birthDate.toIso8601String(),
        // "gender": gender,
        // "phone": phone,
      },
    );

    log(response.data.toString());
    await login(
      email: email,
      password: password,
    );
    return null;
  }
}
