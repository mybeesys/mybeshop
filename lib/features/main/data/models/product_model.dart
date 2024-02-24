import 'package:mybeshop/features/main/data/models/variant_option_model.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';

import 'product_extra_model.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.type,
    required super.image,
    required super.name,
    required super.sku,
    required super.categoryId,
    super.description,
    super.calories,
    required super.currency,
    required super.tax,
    super.hasDiscount,
    super.discountPercent,
    super.originalPrice,
    super.price,
    super.qty,
    super.inStock,
    super.outOfStock,
    super.inCart,
    required super.images,
    required super.extras,
    required super.variantsOptions,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      type: json["type"],
      image: json["image"],
      name: json["name"],
      sku: json["sku"],
      categoryId: json["categoryId"],
      description: json["description"],
      calories: json["calories"] != null ? int.parse(json["calories"]) : null,
      currency: json["currency"],
      tax: json["tax"],
      hasDiscount: json["hasDiscount"],
      discountPercent: json["discountPercent"],
      originalPrice: json["originalPrice"],
      price: json["price"],
      qty: json["qty"],
      inStock: json["inStock"],
      outOfStock: json["outOfStock"],
      inCart: json["inCart"],
      images: json["images"] != null
          ? List.from(json["images"]).map((e) => e.toString()).toList()
          : [],
      extras: json["extras"] == null
          ? []
          : List.from(json["extras"])
              .map((productExtra) => ProductExtraModel.fromJson(productExtra))
              .toList(),
      variantsOptions: json["variantsOptions"] == null
          ? []
          : List.from(json["variantsOptions"])
              .map((e) => VariantOptionModel.fromJson(e))
              .toList(),
    );
  }
}
