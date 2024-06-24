import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:jong/auth/data/repositories/auth_repository.dart';
import 'package:jong/shared/application/cubit/application_cubit.dart';
import 'package:logger/logger.dart';

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

  // Dio
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(
      baseUrl: 'http://85.31.232.97:8000/api',
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
      dio: getIt.get<Dio>(),
    ),
  );

  getIt.registerSingleton<ApplicationCubit>(
    ApplicationCubit(),
  );
}
