import 'package:mybeshop/features/main/data/models/cart_item_model.dart';
import 'package:mybeshop/features/main/data/models/coupon_model.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';

class ShoppingCartModel extends ShoppingCart {
  const ShoppingCartModel({
    required super.subTotal,
    required super.subTotalFotmatted,
    required super.subTotalAfterDiscount,
    required super.subTotalFormattedAfterDiscount,
    required super.tax,
    required super.taxFormatted,
    required super.deliveryFees,
    required super.coupon,
    required super.items,
  });

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    return ShoppingCartModel(
      subTotal: double.parse(json["subTotal"].toString()),
      subTotalFotmatted: json["subTotalFormatted"],
      subTotalAfterDiscount:
          double.parse(json["subTotalAfterDiscount"].toString()),
      subTotalFormattedAfterDiscount: json["subTotalFormattedAfterDiscount"],
      tax: double.parse(json["tax"].toString()),
      taxFormatted: json["taxFormatted"],
      deliveryFees: json["deliveryFees"],
      coupon: CouponModel.fromJson(json["coupon"]),
      items: List.from(json["items"])
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
    );
  }
}
