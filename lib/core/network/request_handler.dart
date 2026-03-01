import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:qunova/core/utils/global_function.dart';

import '../constants/hive_contants.dart';

void addApiInterceptors(Dio dio) {
  dio.options.connectTimeout = const Duration(seconds: 50);
  dio.options.receiveTimeout = const Duration(seconds: 50);
  dio.options.headers['Accept'] = 'application/json';
  dio.options.headers['contentType'] = 'application/json';
  // logger
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );

  // respone handler
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {

        final authBox = Hive.box(HiveContants.authBox);
        final token = authBox.get(HiveContants.authToken);
        if (token != null) {
          options.headers['Authorization'] = "Bearer $token";
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        // Only handle messages if response is a Map (not a List)
        if (response.data is Map<String, dynamic>) {
          final message = response.data['message'];
          switch (response.statusCode) {
            case 401:
              Box authBox = Hive.box(HiveContants.authBox);
              authBox.clear();
              Box userBox = Hive.box(HiveContants.userBox);
              userBox.clear();
              /*Box cartBox = Hive.box<HiveCartModel>(HiveContants.cartBox);
              cartBox.clear();*/
             // AppGlobalFunctions.currentContext?.go(Routes.loginScreen);
              AppGlobalFunctions.showCustomSnackbar(
                message: message,
                isSuccess: false,
              );
              break;
            case 302:
            case 400:
            case 403:
            case 404:
              AppGlobalFunctions.showCustomSnackbar(
                message: message,
                isSuccess: false,
              );
              break;
            case 409:
            case 422:
            case 500:
              AppGlobalFunctions.showCustomSnackbar(
                message: message,
                isSuccess: false,
              );
              break;
            default:
              break;
          }
        }
        handler.next(response);
      },
      onError: (error, handler) {
        if (error.response == null) {
          switch (error.type) {
            case DioExceptionType.connectionError:
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.badResponse:
            case DioExceptionType.sendTimeout:
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.unknown:
              AppGlobalFunctions.showCustomSnackbar(
                message: 'An unknown error occurred',
                isSuccess: false,
              );
              break;
            default:
              break;
          }
        }

        if (error.response != null) {
          final statusCode = error.response!.statusCode;
          final message = error.response!.data is Map<String, dynamic>
            ? error.response!.data['message'] ?? 'Error occurred'
            : 'Error occurred';
          switch (statusCode) {
            case 400:
              AppGlobalFunctions.showCustomSnackbar(
                message: message,
                isSuccess: false,
              );
            case 401:
              Box authBox = Hive.box(HiveContants.authBox);
              authBox.clear();
              Box userBox = Hive.box(HiveContants.userBox);
              userBox.clear();
              /* Box cartBox = Hive.box<HiveCartModel>(HiveContants.cartBox);
              cartBox.clear();*/
              //AppGlobalFunctions.currentContext?.go(Routes.loginScreen);
              break;
            case 403:
              AppGlobalFunctions.showCustomSnackbar(
                message: message,
                isSuccess: false,
              );
              break;
            case 404:
              AppGlobalFunctions.showCustomSnackbar(
                message: message,
                isSuccess: false,
              );
              break;
            default:
              AppGlobalFunctions.showCustomSnackbar(
                message: 'unexpected error',
                isSuccess: false,
              );
              break;
          }
        }
        handler.reject(error);
      },
    ),
  );
}
