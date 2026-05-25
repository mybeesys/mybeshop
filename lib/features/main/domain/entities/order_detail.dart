import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/order_extra.dart';

class OrderDetail extends Equatable {
  final String name;
  final int qty;
  final String price;
  final int cancelled;
  final List<OrderExtra> extras;

  const OrderDetail(
      {required this.name,
      required this.qty,
      required this.price,
      required this.cancelled,
      required this.extras});
  @override
  List<Object?> get props => [name, qty, price, cancelled, extras];
}
