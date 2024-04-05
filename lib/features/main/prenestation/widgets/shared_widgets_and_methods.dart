import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/extenstions.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/domain/entities/variant_option.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_select_widget.dart';

String getTotalPriceAsText(Product product) {
  double totalPrice = 0.0;
  double price = 0.0;
  if (product.type == "basic") {
    price = double.parse(product.price ?? "0");
  } else {
    price = double.parse(CartController.to.variantDetails?.price ?? "0");
  }
  totalPrice =
      (price * CartController.to.qty) + CartController.to.getTotalExtrasPrice();
  return totalPrice.toString();
}

bool checkCanAdd(product) {
  bool canAdd;
  if (product.type == "basic") {
    canAdd = product.inStock!;
  } else {
    canAdd = CartController.to.variantDetails!.inStock!;
  }
  return canAdd;
}

String? getHasExtrasOrVariantsText(Product product) {
  if (product.type == "variants" && product.extras.isEmpty) {
    return "the_product_has_variants".tr;
  } else if (product.type == "variant" && product.extras.isNotEmpty) {
    return "the_product_has_variants_and_extras".tr;
  } else if (product.type == "basic" && product.extras.isNotEmpty) {
    return "the_product_has_extras".tr;
  } else {
    return null;
  }
}

bool checkIsInCart(Product product) {
  bool inCart;
  if (product.type == "basic") {
    inCart = product.inCart!;
  } else {
    inCart = CartController.to.variantDetails!.inCart!;
  }
  return inCart;
}

MaterialButton addToCartButton(
  Product product, {
  height = 140,
  width = double.infinity,
}) {
  return MaterialButton(
    height: (height),
    clipBehavior: Clip.none,
    disabledColor: AppTheme.to.primaryColor.withOpacity(0.4),
    onPressed: CartController.to.productSelectedLoading.value &&
            product == CartController.to.selectedProduct
        ? null
        : () async {
            await addToCartAction(product);
          },
    minWidth: width,
    color: AppTheme.to.primaryColor,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(12),
      bottomRight: Radius.circular(12),
    )),
    child: CartController.to.productSelectedLoading.value &&
            product == CartController.to.selectedProduct
        ? SizedBox(
            width: 100.h,
            height: 100.h,
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
              ),
            ),
          )
        : Text(
            "add_to_cart".tr,
            style: AppStyles.bodyBoldL.copyWith(color: Colors.white),
          ),
  );
}

Widget addToCartMobileButton(Product product) {
  return Material(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
    child: InkWell(
      borderRadius: BorderRadius.circular(32.r),
      // disabledColor: AppTheme.to.primaryColor.withOpacity(0.4),
      onTap: CartController.to.productSelectedLoading.value &&
              product == CartController.to.selectedProduct
          ? null
          : () async {
              await addToCartMobileAction(product);
            },
      child: Container(
        width: 42.h,
        height: 42.h,
        decoration: BoxDecoration(
          color: AppTheme.to.primaryColor,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: CartController.to.productSelectedLoading.value &&
                product == CartController.to.selectedProduct
            ? CircularProgressIndicator(
                strokeWidth: 3,
                color: AppTheme.to.primaryColor,
              )
            : const Icon(
                LineAwesomeIcons.add_to_shopping_cart,
                color: Colors.white,
              ),
      ),
    ),
  );
}

addToCartAction(Product product) async {
  await CartController.to.onProductSelected(product);
  bool canAdd = checkCanAdd(product);
  bool isInCart = checkIsInCart(product);

  log("CAN ADD = ${checkCanAdd(product)}");
  Get.dialog(AlertDialog(
    content: SizedBox(
      width: 500.w,
      child: GetBuilder(
          init: CartController.to,
          builder: (_) {
            return StatefulBuilder(builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            width: double.infinity,
                            height: 300.w,
                            child: Image.network(
                              product.type == "basic"
                                  ? (product.images.isNotEmpty
                                      ? product.images[0]
                                      : "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png")
                                  : CartController.to.variantDetails!.image ??
                                      "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            product.name,
                            style: AppStyles.bodyBoldXL,
                          ),
                          if (product.description != null) ...[
                            SizedBox(height: 10.h),
                            Text(
                              product.description!.removeHtmlTags(),
                              style: AppStyles.bodyRegularS,
                            ),
                          ],
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  "${product.price!} ${product.currency}",
                                  style: AppStyles.bodyBoldL.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              if (product.hasDiscount ?? false) ...[
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    product.originalPrice!,
                                    style: AppStyles.bodyMediumM.copyWith(
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.red),
                                  ),
                                ),
                              ]
                            ],
                          ),
                          if (product.type == "variants") ...[
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                for (VariantOption variantOption
                                    in product.variantsOptions)
                                  CustomSelectWidget(
                                      name: variantOption.libraryName,
                                      onSelected: (v) async {
                                        await Get.find<CartController>()
                                            .onOptionSelected(v);
                                        state(() {
                                          canAdd = checkCanAdd(product);
                                          isInCart = checkIsInCart(product);
                                        });
                                      },
                                      items: variantOption.options
                                          .map((e) => DropdownMenuEntry(
                                              value: e, label: e.name))
                                          .toList()),
                              ],
                            ),
                          ],
                          if (product.extras.isNotEmpty) ...[
                            SizedBox(height: 20.h),
                            Text(
                              "extras".tr,
                              style: AppStyles.bodyBoldM,
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                spacing: 15.w,
                                runSpacing: 15.w,
                                children: [
                                  for (ProductExtra extra in product.extras)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 20.w,
                                            width: 20.w,
                                            child: Checkbox(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.w)),
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -3,
                                                      vertical: -3),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize.padded,
                                              value: CartController.to.extras
                                                  .contains(extra),
                                              onChanged: (v) {
                                                state(() {
                                                  CartController.to
                                                      .onExtraSelected(extra);
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                extra.name,
                                                style: AppStyles.bodyMediumM,
                                              ),
                                              SizedBox(height: 10.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: Text(
                                                      extra.priceFormatted,
                                                      style:
                                                          AppStyles.bodyMediumS,
                                                    ),
                                                  ),
                                                  if (extra.hasDiscount) ...[
                                                    SizedBox(width: 10.w),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      child: Text(
                                                        extra
                                                            .originalPriceFormatted,
                                                        style: AppStyles
                                                            .bodyMediumS
                                                            .copyWith(
                                                                color:
                                                                    Colors.red,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                      ),
                                                    ),
                                                  ]
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                          SizedBox(height: 30.h),
                          // SizedBox(
                          //   height: 130.h,
                          //   child: CustomTextFormFieldWidget(
                          //     icon: Icons.numbers,
                          //     label: "qty".tr,
                          //     iconSize: 25,
                          //     textStyle: AppStyles.bodyRegularM,
                          //   ),
                          // ),
                          InputQty(
                            maxVal: product.type == "basic"
                                ? (product.qty ?? 0)
                                : CartController.to.variantDetails!.qty ?? 0,
                            initVal: CartController.to.qty,
                            minVal: 1,
                            steps: 1,
                            decoration: QtyDecorationProps(
                                btnColor: AppTheme.to.primaryColor),
                            qtyFormProps:
                                QtyFormProps(style: AppStyles.bodyMediumXL),
                            onQtyChanged: (val) =>
                                CartController.to.onQtyChanged(val),
                          ),

                          SizedBox(height: 30.h),
                          CartController.to.variantProductDetailsLoading.value
                              ? Text(
                                  "loading".tr,
                                  style: AppStyles.bodyBoldM,
                                )
                              : Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "${"final_price".tr} "),
                                      TextSpan(
                                        text: getTotalPriceAsText(product),
                                      ),
                                      TextSpan(
                                        text: " ${product.currency}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )
                                    ],
                                    style: AppStyles.bodyBoldM,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        disabledColor: Colors.grey,
                        onPressed: (canAdd == false ||
                                CartController.to.isAddingToCart.value)
                            ? null
                            : () async {
                                if (product.type == "basic") {
                                  if (isInCart) {
                                    CartController.to.deleteItemFromCart(
                                        CartController.to.shoppingCart?.items
                                            .firstWhere((element) =>
                                                element.productId == product.id)
                                            .id,
                                        withBack: true);
                                    product.inCart = false;
                                  } else {
                                    await CartController.to.addToCart();
                                    Get.back();
                                    product.inCart = true;
                                  }
                                } else {
                                  if (isInCart) {
                                    CartController.to.deleteItemFromCart(
                                        CartController.to.shoppingCart?.items
                                            .firstWhere((element) =>
                                                element.productId ==
                                                CartController
                                                    .to.variantDetails!.id)
                                            .id,
                                        withBack: true);
                                  } else {
                                    await CartController.to.addToCart();
                                    Get.back();

                                    CartController.to.variantDetails!.inCart =
                                        true;
                                  }
                                }
                              },
                        minWidth: double.infinity,
                        color: AppTheme.to.primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )),
                        child: isInCart
                            ? Text(
                                "remove_from_cart".tr,
                                style: AppStyles.bodyBoldL.copyWith(
                                  color: Colors.white,
                                ),
                              )
                            : canAdd
                                ? CartController.to.isAddingToCart.value
                                    ? SizedBox(
                                        width: 100.h,
                                        height: 100.h,
                                        child: const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        "add_to_cart".tr,
                                        style: AppStyles.bodyBoldL
                                            .copyWith(color: Colors.white),
                                      )
                                : Text(
                                    "out_of_stock".tr,
                                    style: AppStyles.bodyBoldL.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                      ),
                    )
                  ],
                ),
              );
            });
          }),
    ),
    contentPadding: EdgeInsets.zero,
    actionsPadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ));
}

addToCartMobileAction(Product product) async {
  await CartController.to.onProductSelected(product);
  bool canAdd = checkCanAdd(product);
  bool isInCart = checkIsInCart(product);

  log("CAN ADD = ${checkCanAdd(product)}");
  Get.dialog(AlertDialog(
    content: SizedBox(
      width: 500.w,
      child: GetBuilder(
          init: CartController.to,
          builder: (_) {
            return StatefulBuilder(builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 30.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            width: double.infinity,
                            height: 200.h,
                            child: Image.network(
                              product.type == "basic"
                                  ? (product.images.isNotEmpty
                                      ? product.images[0]
                                      : "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png")
                                  : CartController.to.variantDetails!.image ??
                                      "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            product.name,
                            style: AppStyles.bodyBoldL,
                          ),
                          if (product.description != null) ...[
                            SizedBox(height: 10.h),
                            Text(
                              product.description!.removeHtmlTags(),
                              style: AppStyles.bodyRegularS,
                            ),
                          ],
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  "${product.price!} ${product.currency}",
                                  style: AppStyles.bodyBoldM.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              if (product.hasDiscount ?? false) ...[
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    product.originalPrice!,
                                    style: AppStyles.bodyMediumM.copyWith(
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.red),
                                  ),
                                ),
                              ]
                            ],
                          ),
                          if (product.type == "variants") ...[
                            SizedBox(height: 10.h),
                            Wrap(
                              children: [
                                for (VariantOption variantOption
                                    in product.variantsOptions)
                                  CustomSelectWidget(
                                      width: 200.w,
                                      textStyle: AppStyles.bodyMediumS,
                                      name: variantOption.libraryName,
                                      onSelected: (v) async {
                                        await Get.find<CartController>()
                                            .onOptionSelected(v);
                                        state(() {
                                          canAdd = checkCanAdd(product);
                                          isInCart = checkIsInCart(product);
                                        });
                                      },
                                      items: variantOption.options
                                          .map((e) => DropdownMenuEntry(
                                              value: e, label: e.name))
                                          .toList()),
                              ],
                            ),
                          ],
                          if (product.extras.isNotEmpty) ...[
                            SizedBox(height: 10.h),
                            Text(
                              "extras".tr,
                              style: AppStyles.bodyBoldM,
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                spacing: 15.w,
                                runSpacing: 15.w,
                                children: [
                                  for (ProductExtra extra in product.extras)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 20.w,
                                            width: 20.w,
                                            child: Checkbox(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.w)),
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -3,
                                                      vertical: -3),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize.padded,
                                              value: CartController.to.extras
                                                  .contains(extra),
                                              onChanged: (v) {
                                                state(() {
                                                  CartController.to
                                                      .onExtraSelected(extra);
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                extra.name,
                                                style: AppStyles.bodyMediumM,
                                              ),
                                              SizedBox(height: 10.h),
                                              Text(
                                                extra.originalPriceFormatted,
                                                style: AppStyles.bodyMediumS
                                                    .copyWith(
                                                  color:
                                                      AppTheme.to.primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                          SizedBox(height: 30.h),
                          // SizedBox(
                          //   height: 130.h,
                          //   child: CustomTextFormFieldWidget(
                          //     icon: Icons.numbers,
                          //     label: "qty".tr,
                          //     iconSize: 25,
                          //     textStyle: AppStyles.bodyRegularM,
                          //   ),
                          // ),
                          InputQty(
                            maxVal: product.type == "basic"
                                ? (product.qty ?? 0)
                                : CartController.to.variantDetails!.qty ?? 0,
                            initVal: CartController.to.qty,
                            minVal: 1,
                            steps: 1,
                            decoration: QtyDecorationProps(
                                btnColor: AppTheme.to.primaryColor),
                            onQtyChanged: (val) =>
                                CartController.to.onQtyChanged(val),
                          ),

                          SizedBox(height: 30.h),
                          CartController.to.variantProductDetailsLoading.value
                              ? Text(
                                  "loading".tr,
                                  style: AppStyles.bodyBoldM,
                                )
                              : Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "${"final_price".tr} "),
                                      TextSpan(
                                        text: getTotalPriceAsText(product),
                                      ),
                                      TextSpan(
                                        text: " ${product.currency}",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      )
                                    ],
                                    style: AppStyles.bodyBoldM,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        disabledColor: Colors.grey,
                        onPressed: (canAdd == false ||
                                CartController.to.isAddingToCart.value)
                            ? null
                            : () async {
                                if (product.type == "basic") {
                                  if (isInCart) {
                                    CartController.to.deleteItemFromCart(
                                        CartController.to.shoppingCart?.items
                                            .firstWhere((element) =>
                                                element.productId == product.id)
                                            .id,
                                        withBack: true);
                                    product.inCart = false;
                                  } else {
                                    await CartController.to.addToCart();
                                    Get.back();
                                    product.inCart = true;
                                  }
                                } else {
                                  if (isInCart) {
                                    CartController.to.deleteItemFromCart(
                                        CartController.to.shoppingCart?.items
                                            .firstWhere((element) =>
                                                element.productId ==
                                                CartController
                                                    .to.variantDetails!.id)
                                            .id,
                                        withBack: true);
                                  } else {
                                    await CartController.to.addToCart();
                                    Get.back();

                                    CartController.to.variantDetails!.inCart =
                                        true;
                                  }
                                }
                              },
                        minWidth: double.infinity,
                        color: AppTheme.to.primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        )),
                        height: 50.h,
                        child: isInCart
                            ? Text(
                                "remove_from_cart".tr,
                                style: AppStyles.bodyBoldM.copyWith(
                                  color: Colors.white,
                                ),
                              )
                            : canAdd
                                ? CartController.to.isAddingToCart.value
                                    ? SizedBox(
                                        width: 47.h,
                                        height: 47.h,
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0.h),
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        "add_to_cart".tr,
                                        style: AppStyles.bodyBoldM
                                            .copyWith(color: Colors.white),
                                      )
                                : Text(
                                    "out_of_stock".tr,
                                    style: AppStyles.bodyBoldM.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                      ),
                    )
                  ],
                ),
              );
            });
          }),
    ),
    contentPadding: EdgeInsets.zero,
    actionsPadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ));
}
