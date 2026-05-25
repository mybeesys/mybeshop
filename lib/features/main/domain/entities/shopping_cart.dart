import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/cart_item.dart';
import 'package:mybeshop/features/main/domain/entities/coupon.dart';

class ShoppingCart extends Equatable {
  final double subTotal;
  final String subTotalFotmatted;
  final double subTotalAfterDiscount;
  final String subTotalFormattedAfterDiscount;
  final double tax;
  final String taxFormatted;
  final String deliveryFees;
  final Coupon coupon;
  final List<CartItem> items;

  const ShoppingCart({
    required this.subTotal,
    required this.subTotalFotmatted,
    required this.subTotalAfterDiscount,
    required this.subTotalFormattedAfterDiscount,
    required this.tax,
    required this.taxFormatted,
    required this.deliveryFees,
    required this.coupon,
    required this.items,
  });

  @override
  List<Object?> get props =>
      [subTotal, subTotalFotmatted, tax, taxFormatted, coupon, items];
}
