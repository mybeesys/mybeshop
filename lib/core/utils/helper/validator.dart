import 'package:get/get.dart';
import 'package:mybeshop/core/errors/exceptions.dart';

class Validator {
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName - ${"field_is_required".tr}';
    }
    return null;
  }

  static String? validateEmail(String value, String fieldName) {
    final emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'invalid_email_address'.tr;
    }
    return null;
  }

  static String? validatePhone(String value, String fieldName) {
    final phoneRegex = RegExp(r'(^[0-9]{9,12}$)');
    if (!phoneRegex.hasMatch(value)) {
      return 'invalid_phone_number'.tr;
    }
    return null;
  }

  static Map<String, dynamic> networkValidator(MyBeeException? exception) {
    if (exception != null) {
      if (exception is ValidationException) {
        return exception.error!;
      } else {
        return {};
      }
    }
    return {};
  }

  static String? networkValidatorErrorViewer(
      Map<String, dynamic> error, String fieldName) {
    if (error.keys.contains(fieldName)) {
      return error[fieldName];
    }
    return null;
  }
}
