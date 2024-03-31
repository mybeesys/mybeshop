import 'package:mybeshop/features/main/data/models/order_extra_model.dart';
import 'package:mybeshop/features/main/domain/entities/order_detail.dart';

class OrderDetailModel extends OrderDetail {
  const OrderDetailModel({
    required super.name,
    required super.qty,
    required super.price,
    required super.cancelled,
    required super.extras,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      name: json["name"],
      qty: int.parse(json["qty"].toString()),
      price: json["price"],
      cancelled: int.parse(json["cancelled"].toString()),
      extras: List.from(json["extras"])
          .map((e) => OrderExtraModel.fromJson(e))
          .toList(),
    );
  }
}
