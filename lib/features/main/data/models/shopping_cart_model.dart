import 'package:mybeshop/features/main/data/models/cart_item_model.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';

class ShoppingCartModel extends ShoppingCart {
  const ShoppingCartModel(
      {required super.subTotal,
      required super.subTotalFotmatted,
      required super.tax,
      required super.taxFormatted,
      required super.items});

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    return ShoppingCartModel(
      subTotal: json["subTotal"],
      subTotalFotmatted: json["subTotalFormatted"],
      tax: json["tax"],
      taxFormatted: json["taxFormatted"],
      items: List.from(json["items"])
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }
}
