
import 'package:dio/dio.dart';

class Utils {
  static String extractErrorMessage(dynamic error) {
    try {
      if (error is String) {
        return error;
      }
      if (error is DioException) {
        Response response = error.response!;
        print('darrel ${response.toString()}');
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data is String) {
          return data.toString();
        }
        print('data1 ${data.runtimeType} ${data['message']}');
        return data['message'].toString();
      }

      return error.toString();
    } catch (e) {
      return 'Not connected to internet';
    }
  }
}
