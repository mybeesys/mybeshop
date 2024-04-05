import 'package:mybeshop/features/main/data/models/customer_model.dart';
import 'package:mybeshop/features/main/data/models/price_offer_additional_cost_model.dart';
import 'package:mybeshop/features/main/data/models/price_offer_product_model.dart';
import 'package:mybeshop/features/main/data/models/price_offer_service_model.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer_detail.dart';

class PriceOfferDetailModel extends PriceOfferDetail {
  const PriceOfferDetailModel({
    required super.id,
    required super.no,
    required super.date,
    required super.total,
    required super.discount,
    required super.totalAfterDiscount,
    required super.tax,
    required super.totalWithTax,
    required super.customer,
    required super.products,
    required super.services,
    required super.additionalCosts,
  });

  factory PriceOfferDetailModel.fromJson(Map<String, dynamic> json) {
    return PriceOfferDetailModel(
      id: json["id"],
      no: json["no"],
      date: json["date"],
      total: json["total"],
      discount: json["discount"],
      totalAfterDiscount: json["totalAfterDiscount"],
      tax: json["tax"],
      totalWithTax: json["totalWithTax"],
      customer: CustomerModel.fromJson(json["customer"]),
      products: List.from(json["products"])
          .map((e) => PriceOfferProductModel.fromJson(e))
          .toList(),
      services: List.from(json["services"])
          .map((e) => PriceOfferServiceModel.fromJson(e))
          .toList(),
      additionalCosts: List.from(json["additionalCosts"])
          .map((e) => PriceOfferAdditionalCostModel.fromJson(e))
          .toList(),
    );
  }
}
