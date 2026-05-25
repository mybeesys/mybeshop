// import 'dart:developer';

import 'package:get/get.dart';
import 'package:mybeshop/core/utils/helper/app_dialogs.dart';
import 'package:mybeshop/core/utils/helper/app_loaders_helper.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/domain/entities/cart_item.dart';
import 'package:mybeshop/features/main/domain/entities/option.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';
import 'package:mybeshop/features/main/domain/usecases/add_to_cart_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/clear_shopping_cart_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/delete_item_from_cart_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_shopping_cart_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/get_variant_product_use_case.dart';
import 'package:mybeshop/features/main/domain/usecases/update_cart_use_case.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();

  RxBool shopingCartLoading = false.obs;
  ShoppingCart? shoppingCart;

  Future<void> getShoppingCart() async {
    shopingCartLoading(true);
    update();
    final GetShoppingCartUseCase getShoppingCartUseCase =
        Get.find<GetShoppingCartUseCase>();

    final response = await getShoppingCartUseCase();
    response.fold((failure) {}, (success) {
      shoppingCart = success;
      shopingCartLoading(false);
      if (Get.isRegistered<MainController>()) {
        Get.find<MainController>().update();
      }
      update();
    });
  }

  void clearShoppingCart() async {
    shopingCartLoading(true);
    update();

    final ClearShoppingCartUseCase clearShoppingCartUseCase = Get.find();
    final response = await clearShoppingCartUseCase();
    response.fold((failure) {}, (success) {
      shoppingCart = success;
      shopingCartLoading(false);
      if (Get.isRegistered<MainController>()) {
        Get.find<MainController>().update();
        Get.find<MainController>().onCategorySelected(null);
        Get.find<MainController>().onInit();
      }
      update();
    });
  }

  Product? selectedProduct;
  List<Option> options = [];
  List<int> optionsIds = [];
  List<int> extraIds = [];
  int qty = 1;
  RxBool productSelectedLoading = false.obs;

  void onQtyChanged(int newQty) {
    qty = newQty;
    update();
  }

  Future<void> onProductSelected(p) async {
    options.clear();
    optionsIds.clear();
    extras.clear();
    extraIds.clear();
    selectedProduct = p;
    qty = 1;
    if (selectedProduct?.type == "variants") {
      productSelectedLoading(true);
      update();
      selectedProduct?.variantsOptions.forEach((element) {
        options.add(element.options[0]);
      });
      await getProductVariant();
      productSelectedLoading(false);
    }
    update();
  }

  Future<void> onOptionSelected(Option option) async {
    if (!options.contains(option)) {
      options.removeWhere(
          (element) => element.variantOptionName == option.variantOptionName);
      options.add(option);
    }
    qty = 1;
    await getProductVariant();
  }

  RxBool isAddingToCart = false.obs;
  Future<void> addToCart() async {
    // AppLoaders.showLoading();
    // log(selectedProduct!.name);
    // log(optionsIds.toString());
    if (extras.isNotEmpty) {
      extraIds = extras.map((e) => e.id).toList();
    }
    final AddToCartUseCase addToCartUseCase = Get.find<AddToCartUseCase>();
    isAddingToCart(true);
    update();
    final response = await addToCartUseCase(data: {
      "product_id": "${selectedProduct?.id}",
      "product_type": "${selectedProduct?.type}",
      if (optionsIds.isNotEmpty) "variants_options_ids[]": optionsIds,
      if (extraIds.isNotEmpty) "product_extras_ids[]": extraIds,
      "qty": "$qty",
    });

    response.fold((failure) {
      // log("HERE IS THE FAILURE  : ${failure.toString()}");
      Get.back();
      Get.dialog(AppDialogs.customDialog(
        isLottie: true,
        isLooping: false,
        icon: "error.json",
        title: "error".tr,
        message: failure.message,
        showCancelButton: true,
        onPressed: () {
          Get.back();
        },
      ));
    }, (success) {
      shoppingCart = success;
      AppLoaders.hideLoading();
      isAddingToCart(false);
      if (Get.isRegistered<MainController>()) {
        Get.find<MainController>().update();
      }
      update();
      Get.back();
    });
  }

  void updateCart(CartItem product, {bool isIncrease = false}) async {
    AppLoaders.showLoading();
    final UpdateCartUseCase updateCartUseCase = Get.find();
    final response = await updateCartUseCase(data: {
      "id": product.id,
      "qty": "${product.qty + (isIncrease ? 1 : -1)}",
    });
    response.fold((failure) {}, (success) {
      shoppingCart = success;
      AppLoaders.hideLoading();
      update();
    });
  }

  void deleteItemFromCart(id, {int? extraId, bool withBack = false}) async {
    AppLoaders.showLoading(); // log(selectedProduct!.name);
    // log(optionsIds.toString());
    // log(extraId.toString());
    final DeleteItemFromCartUseCase deleteItemFromCartUseCase =
        Get.find<DeleteItemFromCartUseCase>();
    final response = await deleteItemFromCartUseCase(data: {
      "id": id,
      if (extraId != null) "product_extras_ids_to_remove[]": extraId
    });

    response.fold((failure) {}, (success) {
      var productId = shoppingCart!.items
          .firstWhere((element) => element.id == id)
          .productId;
      AppLoaders.hideLoading();
      shoppingCart = success;
      if (Get.isRegistered<MainController>()) {
        Get.find<MainController>().setProductInCart(productId);
        Get.find<MainController>().update();
      }
      if (withBack) {
        Get.back();
      }
      update();
    });
  }

  Product? variantDetails;
  RxBool variantProductDetailsLoading = false.obs;
  Future<void> getProductVariant() async {
    variantProductDetailsLoading(true);
    update();
    optionsIds = options.map((e) => e.id).toList();

    final GetVariantProductUseCase getVariantProductUseCase = Get.find();
    final response = await getVariantProductUseCase(data: {
      "product_id": "${selectedProduct?.id}",
      "variants_options_id[]": optionsIds,
    });
    response.fold((failure) {}, (success) {
      // log("${success.price} .... ,,,,, ..... ,,,,, ....");
      variantDetails = success;
      variantProductDetailsLoading(false);
      update();
    });
  }

  List<ProductExtra> extras = [];
  void onExtraSelected(ProductExtra extra) {
    if (extras.contains(extra)) {
      extras.remove(extra);
    } else {
      extras.add(extra);
    }
  }

  double getTotalExtrasPrice() {
    double price = 0;
    for (var element in extras) {
      price = price + double.parse(element.price);
    }
    return price;
  }

  @override
  void onInit() {
    // clearShoppingCart();
    if (GlobalController.to.baseURL!.contains("shop")) {
      getShoppingCart();
    }
    super.onInit();
  }
}
