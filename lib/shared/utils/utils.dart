import 'package:dio/dio.dart';

class Utils {
  static String extractErrorMessage(dynamic error) {
    try {
      if (error is String) {
        return error;
      }
      if (error is DioException) {
        var data = error.response?.data;
        if (data is String) {
          return data;
        }
        if (data is Map) {
          var msg = data['detail'];
          if (msg is String) {
            return msg;
          }
        }
      }

      return error.toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
