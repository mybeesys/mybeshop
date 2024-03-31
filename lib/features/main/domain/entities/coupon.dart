import 'package:equatable/equatable.dart';

class Coupon extends Equatable {
  final int? id;
  final String? code;
  final bool valid;
  final double? percent;
  final double? amount;

  const Coupon({
    required this.id,
    required this.code,
    required this.valid,
    required this.percent,
    required this.amount,
  });

  @override
  List<Object?> get props => [id, code, valid, percent, amount];
}
