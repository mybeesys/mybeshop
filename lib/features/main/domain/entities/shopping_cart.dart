import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/cart_item.dart';

class ShoppingCart extends Equatable {
  final double subTotal;
  final String subTotalFotmatted;
  final double tax;
  final String taxFormatted;
  final List<CartItem> items;

  const ShoppingCart({
    required this.subTotal,
    required this.subTotalFotmatted,
    required this.tax,
    required this.taxFormatted,
    required this.items,
  });

  @override
  List<Object?> get props =>
      [subTotal, subTotalFotmatted, tax, taxFormatted, items];
}
