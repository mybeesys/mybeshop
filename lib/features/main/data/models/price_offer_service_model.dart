import 'package:mybeshop/features/main/domain/entities/price_offet_service.dart';

class PriceOfferServiceModel extends PriceOfferService {
  const PriceOfferServiceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.tax,
    required super.subTotal,
  });

  factory PriceOfferServiceModel.fromJson(Map<String, dynamic> json) {
    return PriceOfferServiceModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        tax: json["tax"],
        subTotal: json["subTotal"]);
  }
}
