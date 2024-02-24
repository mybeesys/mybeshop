import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppMessages {
  static showSnackBar({
    ErrorType type = ErrorType.success,
    String? title = "success",
    String? message = "",
    int duration = 2,
  }) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: _getColor(type),
      icon: Icon(_getIcon(type)),
      title: title!.tr,
      message: message!.tr,
      duration: Duration(seconds: duration),
    ));
  }

  static Color _getColor(ErrorType type) {
    switch (type) {
      case ErrorType.success:
        return Colors.green;
      case ErrorType.warning:
        return Colors.orange;
      case ErrorType.error:
        return Colors.red;
      default:
        return Colors.black26;
    }
  }

  static IconData _getIcon(ErrorType type) {
    switch (type) {
      case ErrorType.success:
        return Icons.check;
      case ErrorType.warning:
        return Icons.info;
      case ErrorType.error:
        return Icons.close;
      default:
        return Icons.check;
    }
  }
}

enum ErrorType { success, warning, error }
