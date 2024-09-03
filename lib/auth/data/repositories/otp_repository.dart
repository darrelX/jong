import 'package:dio/dio.dart';
import 'package:jong/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpRepository {
  final Dio dio;
  final Future<SharedPreferences>? prefs;

   OtpRepository() : dio = getIt.get<Dio>(), prefs = getIt<Future<SharedPreferences>>();
}
