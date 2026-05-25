import 'package:mybeshop/features/main/domain/entities/order_extra.dart';

class OrderExtraModel extends OrderExtra {
  const OrderExtraModel({required super.name, required super.price});
  factory OrderExtraModel.fromJson(Map<String, dynamic> json) {
    return OrderExtraModel(name: json["name"], price: json["price"]);
  }
}
