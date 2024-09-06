import 'package:dio/dio.dart';
import 'package:jong/service_locator.dart';

class GameRepository {
  final Dio dio;
  GameRepository() : dio = getIt.get<Dio>();

  Future<void> gameResult(Map<String, dynamic> json) async {
    try {
      final Response response = await dio.post('/game-rounds', data: json);
    } catch (e) {
      rethrow;
    }
  }

  
}
