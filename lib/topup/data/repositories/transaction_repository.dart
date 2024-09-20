import 'package:dio/dio.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/topup/data/models/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionRepository {
  final Dio dio;
  final Future<SharedPreferences> prefs;

  TransactionRepository()
      : dio = getIt.get<Dio>(),
        prefs = getIt.get<Future<SharedPreferences>>();

  Future<TransactionModel> deposit(
      {required String method,
      required int amount,
      required int userId,
      required String phoneNumber}) async {
    try {
      final response = await dio.post('/deposits', data: {
        "method": method,
        "amount": amount,
        "user_id": userId,
        "phone_number": phoneNumber
      });
      return TransactionModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getStatus({required int id}) async {
    try {
      final Response response = await dio.get('/deposits/$id');
      // print("number ${response.data['status']}");
      // final x = response.data[]
      return response.data['status'];
    } catch (e) {
      print('Error bro');
      rethrow;
    }

    //  DepositModel.fromJson(response.data["data"], response.data["total"]);
  }
}
