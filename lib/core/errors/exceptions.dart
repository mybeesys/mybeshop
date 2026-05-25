class MyBeeException implements Exception {
  final int? code;
  final String message;

  MyBeeException({this.code, required this.message});
}

class UnAuthorizedException implements MyBeeException {
  @override
  final String message;
  @override
  final int? code;

  UnAuthorizedException(this.message, {this.code});
}

class ValidationException implements MyBeeException {
  @override
  final String message;
  @override
  final int? code;
  final Map<String, dynamic>? error;
  ValidationException(this.message, {this.error, this.code});
}

class BadRequestException implements MyBeeException {
  @override
  final String message;
  @override
  final int? code;
  BadRequestException(this.message, {this.code});
}

class RequestTimeoutException implements MyBeeException {
  @override
  final String message;
  @override
  final int? code;
  RequestTimeoutException(this.message, {this.code});
}

class NoInternetException implements MyBeeException {
  @override
  final String message;
  @override
  final int? code;

  NoInternetException(this.message, {this.code});
}

class ForbiddenException implements MyBeeException {
  @override
  final String message;
  @override
  final int? code;

  ForbiddenException(this.message, {this.code});
}

class NotFoundException implements MyBeeException {
  @override
  final String message;
  @override
  final int? code;

  NotFoundException(this.message, {this.code});
}
