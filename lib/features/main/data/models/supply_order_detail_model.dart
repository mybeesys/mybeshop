import 'package:mybeshop/features/main/data/models/supplier_model.dart';
import 'package:mybeshop/features/main/data/models/supply_order_item_model.dart';
import 'package:mybeshop/features/main/domain/entities/supply_order_detail.dart';

class SupplyOrderDetailModel extends SupplyOrderDetail {
  const SupplyOrderDetailModel({
    required super.id,
    required super.no,
    required super.date,
    required super.supplier,
    required super.items,
  });

  factory SupplyOrderDetailModel.fromJson(Map<String, dynamic> json) {
    return SupplyOrderDetailModel(
      id: json["id"],
      no: json["no"],
      date: json["date"],
      supplier: SupplierModel.fromJson(json["supplier"]),
      items: List.from(json["items"])
          .map((e) => SupplyOrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
