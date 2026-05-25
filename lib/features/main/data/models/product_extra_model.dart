import 'package:mybeshop/features/main/domain/entities/product_extra.dart';

class ProductExtraModel extends ProductExtra {
  const ProductExtraModel({
    required super.id,
    required super.name,
    required super.hasDiscount,
    required super.originalPrice,
    required super.price,
    required super.originalPriceFormatted,
    required super.priceFormatted,
    required super.inStock,
  });

  factory ProductExtraModel.fromJson(Map<String, dynamic> json) {
    return ProductExtraModel(
      id: json["id"],
      name: json["name"],
      hasDiscount: json["hasDiscount"],
      originalPrice: json["originalPrice"],
      price: json["price"],
      originalPriceFormatted: json["originalPriceFormatted"],
      priceFormatted: json["priceFormatted"],
      inStock: json["inStock"],
    );
  }
}
