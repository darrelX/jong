import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/history/data/models/ticket_model.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shop/data/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketRepository {
  final Dio dio;
  final Future<SharedPreferences> prefs;
  final ProductRepository repository;

  TicketRepository(
      {required Dio dio,
      required Future<SharedPreferences> prefs,
      required ProductRepository repository})
      : dio = getIt.get<Dio>(),
        prefs = getIt.get<Future<SharedPreferences>>(),
        repository = getIt.get<ProductRepository>();

  Future<List<TicketModel>?> createTicket(String token, String quantity) async {
    try {
      Response response = await dio.post('/tickets', data: {});
    } catch (e) {
      return null;
    }
    // return TicketModel.fromJson(response.data);
  }

  Future<List<TicketModel>?> fetchTicketsList() async {
    try {
      Response response = await dio.get('/tickets');
      List<dynamic> tickets = response.data['data'] as List<dynamic>;
      List<TicketModel> ticketsList = tickets
          .map((item) => TicketModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return ticketsList;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
