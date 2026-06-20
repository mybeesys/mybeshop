import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';

String getTotalPriceAsText(Product product) {
  double price = 0.0;
  if (product.type == 'basic') {
    price = double.parse(product.price ?? '0');
  } else {
    price = double.parse(CartController.to.variantDetails?.price ?? '0');
  }
  final total =
      (price * CartController.to.qty) + CartController.to.getTotalExtrasPrice();
  return total.toString();
}

bool checkCanAdd(Product product) {
  if (product.type == 'basic') {
    return product.inStock ?? false;
  }
  return CartController.to.variantDetails?.inStock ?? false;
}

bool checkIsInCart(Product product) {
  if (product.type == 'basic') {
    return product.inCart ?? false;
  }
  return CartController.to.variantDetails?.inCart ?? false;
}
