import 'package:dio/dio.dart';
import 'package:jong/history/data/models/game_history_model.dart';
import 'package:jong/service_locator.dart';

class GameHistoryRepository {
  final Dio dio = getIt.get<Dio>();
  GameHistoryRepository();

  Future<List<GameHistoryModel>?> fetchGameHistory(int userId) async {
    try {
      final Response response =
          await dio.get('/game-rounds', queryParameters: {"user_id": userId});
      List<dynamic> history = response.data['data'] as List<dynamic>;
      List<GameHistoryModel> gameHistoryList = history
          .map(
              (item) => GameHistoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return gameHistoryList;
    } catch (e) {
      print(e.toString());

      rethrow;
    }
  }
}
