import 'package:mybeshop/features/main/domain/entities/supply_order_item.dart';

class SupplyOrderItemModel extends SupplyOrderItem {
  const SupplyOrderItemModel(
      {required super.id, required super.name, required super.qty});

  factory SupplyOrderItemModel.fromJson(Map<String, dynamic> json) {
    return SupplyOrderItemModel(
      id: json["id"],
      name: json["name"],
      qty: int.parse(json["qty"].toString()),
    );
  }
}
