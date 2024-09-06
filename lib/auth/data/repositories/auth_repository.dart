import 'dart:developer';
import 'package:dio/dio.dart';
// Assurez-vous que cet import est nécessaire
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthRepository {
  final Dio dio;
  final Future<SharedPreferences>? prefs;

  AuthRepository({
    required this.dio,
    this.prefs,
  });

  Future<UserModel?> _saveTokenAndFetchUser(String token) async {
    SharedPreferences storage = await prefs!;
    storage.setString('token', token);
    return getUser();
  }

  Future<UserModel?> getUser() async {
    SharedPreferences storage = await prefs!;
    String? token = storage.getString('token');

    if (token == null) {
      log("No token found in storage.");
      return null;
    }

    try {
      Response response = await dio.get(
        '/auth/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      log("Failed to get user: ${e.toString()}");
      rethrow;
    }
  }

  Future<UserModel?> login({
    required String phone,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        '/auth/login',
        data: {
          "phone_number": phone,
          "password": password,
        },
      );

      if (response.data != null && response.data['token'] != null) {
        return _saveTokenAndFetchUser(response.data['token']);
      } else {
        log("Login failed: Token is missing from the response.");
        return null;
      }
    } catch (e) {
      log("Login error: ${e.toString()}");
      rethrow;

    }
  }

  Future<UserModel?> register({
    required String username,
    required String email,
    required DateTime birthDate,
    required int gender,
    required String phone,
    required String password,
  }) async {
    try {
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

      log("Registration response: ${response.data.toString()}");

      if (response.data != null && response.data['token'] != null) {
        return _saveTokenAndFetchUser(response.data['token']);
      } else {
        log("Registration failed: Token is missing from the response.");
        return null;
      }
    } catch (e) {
      log("Registration error: ${e.toString()}");
      rethrow;

    }
  }
}
