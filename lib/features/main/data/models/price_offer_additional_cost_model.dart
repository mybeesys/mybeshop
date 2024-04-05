import 'package:mybeshop/features/main/domain/entities/price_offer_additional_cost.dart';

class PriceOfferAdditionalCostModel extends PriceOfferAdditionalCost {
  const PriceOfferAdditionalCostModel({
    required super.id,
    required super.name,
    required super.description,
    required super.cost,
  });

  factory PriceOfferAdditionalCostModel.fromJson(Map<String, dynamic> json) {
    return PriceOfferAdditionalCostModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      cost: json["cost"],
    );
  }
}
