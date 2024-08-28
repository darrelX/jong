
import 'package:dio/dio.dart';

class Utils {
  static String extractErrorMessage(dynamic error) {
    try {
      if (error is String) {
        return error;
      }
      if (error is DioException) {
        Response response = error.response!;
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data is String) {
          return data.toString();
        }
        return data['message'].toString();
      }

      return error.toString();
    } catch (e) {
      return 'Not connected to internet';
    }
  }
}
