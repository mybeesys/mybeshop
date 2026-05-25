import 'package:mybeshop/features/main/data/models/order_extra_model.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer_product.dart';

class PriceOfferProductModel extends PriceOfferProduct {
  const PriceOfferProductModel({
    required super.id,
    required super.name,
    required super.unitPrice,
    required super.qty,
    required super.discount,
    required super.tax,
    required super.extras,
    required super.subTotal,
  });

  factory PriceOfferProductModel.fromJson(Map<String, dynamic> json) {
    return PriceOfferProductModel(
        id: json["id"],
        name: json["name"],
        unitPrice: json["unitPrice"],
        qty: int.parse(json["qty"].toString()),
        discount: json["discount"],
        tax: json["tax"],
        extras: List.from(json["extras"])
            .map((e) => OrderExtraModel.fromJson(e))
            .toList(),
        subTotal: json["subTotal"]);
  }
}
