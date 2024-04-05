import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/order_extra.dart';

class PriceOfferProduct extends Equatable {
  final int id;
  final String name;
  final String unitPrice;
  final int qty;
  final String discount;
  final String tax;
  final List<OrderExtra> extras;
  final String subTotal;

  const PriceOfferProduct(
      {required this.id,
      required this.name,
      required this.unitPrice,
      required this.qty,
      required this.discount,
      required this.tax,
      required this.extras,
      required this.subTotal});

  @override
  List<Object?> get props =>
      [id, name, unitPrice, qty, discount, tax, extras, subTotal];
}
