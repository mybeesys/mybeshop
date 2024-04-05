import 'package:mybeshop/features/global/data/models/store_info_model.dart';
import 'package:mybeshop/features/main/data/models/supply_order_detail_model.dart';
import 'package:mybeshop/features/main/domain/entities/supply_order.dart';

class SupplyOrderModel extends SupplyOrder {
  const SupplyOrderModel({
    required super.store,
    required super.termsAndConditions,
    required super.supplyOrderDetail,
  });

  factory SupplyOrderModel.fromJson(Map<String, dynamic> json) {
    return SupplyOrderModel(
        store: StoreInfoModel.fromJson(json["store"]),
        termsAndConditions: json["termsAndConditions"],
        supplyOrderDetail:
            SupplyOrderDetailModel.fromJson(json["supplyOrder"]));
  }
}
