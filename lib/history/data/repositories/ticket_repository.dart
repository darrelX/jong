import 'package:dio/dio.dart';
import 'package:jong/history/data/models/ticket_model.dart';

class TicketRepository {
  final Dio dio;

  TicketRepository({required this.dio});

  Future<TicketModel> createTicket(String userId, String quantity) async {
    Response response = await dio.post(
      '/users/', data: {}
    );
    return TicketModel.fromJson(response.data);
  }


}
