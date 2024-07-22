import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:jong/history/data/models/product_ticket_model.dart';
import 'package:jong/history/data/models/ticket_model.dart';
import 'package:jong/service_locator.dart';
import 'package:jong/shop/data/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketRepository {
  final Dio dio;
  final Future<SharedPreferences>? prefs;
  final ProductRepository? repository;

  TicketRepository(
      {required this.dio, required this.prefs, required this.repository});

  Future<List<TicketModel>?> fetchTicketsList(int userId) async {
    try {
      Response response =
          await dio.get('/tickets', queryParameters: {"user_id": userId});
      // print("dada ${response.data}");
      List<dynamic> tickets = response.data['data'] as List<dynamic>;
      List<TicketModel> ticketsList = tickets
          .map((item) => TicketModel.fromJson(item as Map<String, dynamic>))
          .toList();
      // log("dada ${ticketsList.toString()}");

      return ticketsList;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Future<List<ProductTicketModel>> fetchProductsTicket(String id) async{

  // }
}
