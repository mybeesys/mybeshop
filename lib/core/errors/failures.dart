import 'package:equatable/equatable.dart';
import 'package:mybeshop/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final int? code;
  final String? message;
  final MyBeeException? exception;
  const Failure({this.code, this.message, this.exception});
}

class ServerFailure extends Failure {
  const ServerFailure({super.code, super.message, super.exception});
  @override
  List<Object?> get props => [code, message, exception];
}
