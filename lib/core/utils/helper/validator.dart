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

  /// Matches Saudi mobile numbers in any common form: 05XXXXXXXX,
  /// 5XXXXXXXX, 9665XXXXXXXX, +9665XXXXXXXX, 009665XXXXXXXX.
  static final RegExp _saudiPhoneRegex = RegExp(r'^(00966|966|0)?5\d{8}$');

  static String _sanitizePhone(String value) {
    final withoutSeparators = value.replaceAll(RegExp(r'[\s\-()]'), '');
    return withoutSeparators.startsWith('+')
        ? withoutSeparators.substring(1)
        : withoutSeparators;
  }

  static String? validateSaudiPhone(String? value, String fieldName) {
    final requiredMessage = validateRequired(value, fieldName);
    if (requiredMessage != null) {
      return requiredMessage;
    }
    if (!_saudiPhoneRegex.hasMatch(_sanitizePhone(value!))) {
      return 'invalid_phone_number'.tr;
    }
    return null;
  }

  /// Normalizes any accepted Saudi phone form to `966XXXXXXXXX`.
  static String normalizeSaudiPhone(String value) {
    final sanitized = _sanitizePhone(value);
    final national = sanitized.substring(sanitized.length - 9);
    return '966$national';
  }

  /// Like [normalizeSaudiPhone] but tolerant: returns the trimmed input
  /// unchanged if it isn't a recognizable Saudi number instead of throwing.
  static String normalizeSaudiPhoneIfValid(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || !_saudiPhoneRegex.hasMatch(_sanitizePhone(trimmed))) {
      return trimmed;
    }
    return normalizeSaudiPhone(trimmed);
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
