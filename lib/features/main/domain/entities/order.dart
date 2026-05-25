import 'package:equatable/equatable.dart';
import 'package:mybeshop/features/main/domain/entities/customer.dart';
import 'package:mybeshop/features/main/domain/entities/order_detail.dart';

class Order extends Equatable {
  final int id;
  final String no;
  final String status;
  final String paymentMethod;
  final String discount;
  final String delivery;
  final String tax;
  final String total;
  final Customer customer;
  final List<OrderDetail> details;

  const Order(
      {required this.id,
      required this.no,
      required this.status,
      required this.paymentMethod,
      required this.discount,
      required this.delivery,
      required this.tax,
      required this.total,
      required this.customer,
      required this.details});

  @override
  List<Object?> get props => [
        id,
        no,
        status,
        paymentMethod,
        discount,
        delivery,
        tax,
        total,
        customer,
        details
      ];
}
