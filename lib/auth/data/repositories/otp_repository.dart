import 'package:dio/dio.dart';
import 'package:jong/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpRepository {
  final Dio _dio;
  final Future<SharedPreferences>? _prefs;

  OtpRepository()
      : _dio = getIt.get<Dio>(),
        _prefs = getIt<Future<SharedPreferences>>();

  Future<bool> submit(
      {required String code, required String phoneNumber}) async {
    try {
      final Response response = await _dio.post('/otp/verify',
          data: {"phone_number": phoneNumber, "code": code});
      if (response.statusCode! == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    try {
      final Response response =
          await _dio.post('/otp/send', data: {"phone_number": phoneNumber});
    } catch (e) {
      rethrow;
    }
  }
}
