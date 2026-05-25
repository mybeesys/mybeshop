import 'package:mybeshop/features/main/domain/entities/coupon.dart';

class CouponModel extends Coupon {
  const CouponModel({
    required super.id,
    required super.code,
    required super.valid,
    required super.percent,
    required super.amount,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json["id"],
      code: json["code"],
      valid: json["valid"],
      percent: json["percent"],
      amount: json["amount"],
    );
  }
}
