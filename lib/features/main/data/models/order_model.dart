import 'package:mybeshop/features/main/data/models/customer_model.dart';
import 'package:mybeshop/features/main/data/models/order_detail_model.dart';
import 'package:mybeshop/features/main/domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.no,
    required super.status,
    required super.paymentMethod,
    required super.discount,
    required super.delivery,
    required super.tax,
    required super.total,
    required super.customer,
    required super.details,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json["id"],
        no: json["no"],
        status: json["status"],
        paymentMethod: json["paymentMethod"],
        discount: json["discount"],
        delivery: json["delivery"],
        tax: json["tax"],
        total: json["total"],
        customer: CustomerModel.fromJson(json["customer"]),
        details: List.from(json["details"])
            .map((detail) => OrderDetailModel.fromJson(detail))
            .toList());
  }
}
