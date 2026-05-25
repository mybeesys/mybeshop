import 'dart:developer';
import 'package:get/get.dart';
import 'package:mybeshop/core/errors/exceptions.dart';

class NetworkErrorHandler {
  static MyBeeException networkHandler(e) {
    log("This is socket exception from the network handler $e");
    var exception = "$e";
    if (exception.contains("HttpException")) {
      throw NoInternetException("${"no_internet_access".tr} $e");
    } else {
      throw RequestTimeoutException("unknown_error".tr);
    }
  }
}
