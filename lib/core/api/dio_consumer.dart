import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:mybeshop/core/api/api_consumer.dart';
import 'package:mybeshop/core/api/app_interceptors.dart';
import 'package:mybeshop/core/api/error_handler.dart';
import 'package:mybeshop/core/api/status_codes.dart';
import 'package:mybeshop/core/errors/exceptions.dart';

import '../config/app_config.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;
  DioConsumer({required this.client}) {
    client.options
      ..baseUrl = AppConfig.baseURL
      ..responseType = ResponseType.plain
      ..connectTimeout = const Duration(seconds: 30)
      ..followRedirects = false
      ..receiveDataWhenStatusError = true
      ..validateStatus = (status) {
        return [200, 201].contains(status!);
      };

    // Add Interceptors
    // client.interceptors.add(LogInterceptor());
    // if (kDebugMode) {
    client.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
    // }
    client.interceptors.add(AppInterceptos());
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return jsonDecode(response.data.toString());
    } on DioException catch (e) {
      _handleDioExceptions(e);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.post(path,
          data: body != null ? FormData.fromMap(body) : body,
          queryParameters: queryParameters);
      return jsonDecode(response.data.toString());
    } on DioException catch (e) {
      _handleDioExceptions(e);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.put(path,
          data: body != null ? FormData.fromMap(body) : body,
          queryParameters: queryParameters);
      return jsonDecode(response.data.toString());
    } on DioException catch (e) {
      _handleDioExceptions(e);
    }
  }

  @override
  Future delete(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.delete(path,
          data: body != null ? FormData.fromMap(body) : body,
          queryParameters: queryParameters);
      return jsonDecode(response.data.toString());
    } on DioException catch (e) {
      _handleDioExceptions(e);
    }
  }

  _handleDioExceptions(DioException err) {
    switch (err.type) {
      case DioExceptionType.badResponse:
        var response = jsonDecode(err.response?.data);
        switch (err.response?.statusCode) {
          case StatusCode.unauthorized:
            log("Error : This is the un authorized exception");
            log(getx.Get.currentRoute);
            throw UnAuthorizedException(response["message"]);
          case StatusCode.validationError:
            throw ValidationException(
                _getMessageFromValidationError(response) ?? "Validation Error",
                error: _getValidationErrors(response),
                code: StatusCode.validationError);
          case StatusCode.badRequest:
            throw BadRequestException(response["message"]);
          case StatusCode.forbidden:
            throw ForbiddenException(response["message"]);
          case StatusCode.notFound:
            throw NotFoundException(response["message"]);
        }
        break;
      case DioExceptionType.connectionTimeout:
        log("Connection Timeout Exception - Dio Consiumer");
        throw RequestTimeoutException("request_timeout".tr);
      case DioExceptionType.unknown:
        throw NetworkErrorHandler.networkHandler(err.error);
      case DioExceptionType.connectionError:
        throw NoInternetException("${"no_internet_access".tr} ${err.error}");
      default:
    }
  }

  String? _getMessageFromValidationError(response) {
    if (response.containsKey("errors")) {
      String? message;
      var errors = response["errors"];
      // Displaying error messages
      errors.forEach((key, value) {
        message = value;
      });
      return message.toString();
    } else {
      return "Validation Error";
    }
  }

  _getValidationErrors(response) {
    if (response.containsKey("errors")) {
      var errors = response["errors"];
      return errors;
    } else {
      return {};
    }
  }
}
