import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jong/auth/data/repositories/auth_repository.dart';
import 'package:jong/history/data/repositories/ticket_repository.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
import 'package:jong/shop/data/repositories/product_repository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/networking/http_logger_interceptor.dart';
import 'shared/networking/token_interceptor.dart';
import 'shared/routing/app_router.dart';

final getIt = GetIt.instance;

void setupLocator() {
  //route
  getIt.registerSingleton<AppRouter>(AppRouter());

  //logger
  getIt.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(colors: true),
    ),
  );

  // SharedPreferences
  getIt.registerLazySingleton<Future<SharedPreferences>>(
      () async => SharedPreferences.getInstance());

  // Dio
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(
      baseUrl: 'https://jong-api.symphonisocial.com/api',
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 12),
      headers: {
        'Accept': 'application/json',
      },
    ))
      ..interceptors.addAll(
        [
          TokenInterceptor(),
          HttpLoggerInterceptor(),
        ],
      ),
  );

  getIt.registerSingleton<AuthRepository>(
    AuthRepository(
        dio: getIt.get<Dio>(), prefs: getIt.get<Future<SharedPreferences>>()),
  );

  getIt.registerSingleton<ProductRepository>(
    ProductRepository(
        dio: getIt.get<Dio>(), prefs: getIt.get<Future<SharedPreferences>>()),
  );

  getIt.registerSingleton<TicketRepository>(
    TicketRepository(
        dio: getIt.get<Dio>(),
        prefs: getIt.get<Future<SharedPreferences>>(),
        repository: getIt.get<ProductRepository>()),
  );

  getIt.registerSingleton<ApplicationCubit>(
    ApplicationCubit(),
  );
}
