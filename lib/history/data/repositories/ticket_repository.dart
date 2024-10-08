import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/history/data/models/ticket_model.dart';
import 'package:jong/shop/data/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketRepository {
  final Dio dio;
  final Future<SharedPreferences>? prefs;
  final ProductRepository? repository;

  TicketRepository(
      {required this.dio, required this.prefs, required this.repository});

  Future<List<TicketModel>?> fetchTicketsList(int userId) async {
    final List<TicketModel> ticketsList;
    try {
      Response response = await dio.get('/tickets');
      // int total = response.data['total'] as int;
      response = await dio.get('/tickets', queryParameters: {
        "user_id": userId,
      });
      List<dynamic> tickets = response.data['data'] as List<dynamic>;

      ticketsList = tickets
          .map((item) => TicketModel.fromJson(item as Map<String, dynamic>))
          .toList();
      // log("dada ${ticketsList.toString()}");

      return ticketsList;
    } catch (e) {
      log("$e");
      rethrow;
    }
  }

  // Future<List<ProductTicketModel>> fetchProductsTicket(String id) async{

  // }
}
