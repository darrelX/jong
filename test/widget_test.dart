import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() async {
  configureDependencies(); // Configurer les dépendances

  final dio = getIt<Dio>(); // Utiliser getIt directement
  try {
    final response = await dio.post(
      '/login',
      data: {
        'email': 'darrel@gmail.com',
        'password': 'arafat',
      },
    );

    // Utilisez la réponse
    print(response.data);
  } catch (error) {
    // Gérez les erreurs
    print(error.toString());
  }
}

void configureDependencies() {
  getIt.registerSingleton<Dio>(Dio(BaseOptions(
    baseUrl: 'https://be04-145-224-72-79.ngrok-free.app/api',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
    },
  )));
}