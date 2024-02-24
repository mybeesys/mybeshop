import 'package:mybeshop/features/main/data/models/product_extra_model.dart';
import 'package:mybeshop/features/main/domain/entities/cart_item.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.uuid,
    required super.id,
    required super.storeSlug,
    required super.image,
    required super.name,
    required super.type,
    required super.productId,
    required super.productVariantId,
    required super.qty,
    required super.maxQty,
    required super.price,
    required super.priceFormatted,
    required super.createdAt,
    required super.extras,
  });
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      uuid: json["uuid"],
      id: json["id"],
      storeSlug: json["storeSlug"],
      image: json["image"],
      name: json["name"],
      type: json["type"],
      productId: json["productId"],
      productVariantId: json["productVariantId"] != null
          ? int.parse(json["productVariantId"].toString())
          : null,
      qty: int.parse(json["qty"].toString()),
      maxQty: json["maxQty"],
      price: json["price"],
      priceFormatted: json["priceFormatted"],
      createdAt: json["createdAt"],
      extras: List.from(json["extras"])
          .map((extra) => ProductExtraModel.fromJson(extra))
          .toList(),
    );
  }
}
