import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../service_locator.dart';

var appLogger = getIt.get<Logger>();

class HttpLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      try {
        appLogger.d({
          "base_url": options.baseUrl,
          "url": options.path,
          "method": options.method,
          "params": options.queryParameters,
          "body": options.data,
          'headers': options.headers.toString(),
          "all": options.uri.toString()
        });
      } catch (e) {
        appLogger.e(e.toString());
      }
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, handler) {
    return handler.next(response);
  }

  @override
  void onError(DioException err, handler) {
    if (kDebugMode) {
      try {
        appLogger.e(
          {
            "base_url": err.requestOptions.baseUrl,
            "path": err.requestOptions.path,
            "method": err.requestOptions.method,
            "data": err.requestOptions.data,
            "params": err.requestOptions.queryParameters,
            "original": err.message,
            'headers': err.requestOptions.headers.toString(),
            'message': err.response?.data,
          },
        );
      } catch (e) {
        appLogger.e(e.toString());
      }
    }

    return handler.next(err);
  }
}
