// import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mybeshop/core/widgets/app_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/currency/riyal_formatter.dart';
import 'package:mybeshop/core/widgets/riyal_price_text.dart';
import 'package:mybeshop/core/utils/helper/extenstions.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/domain/entities/variant_option.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_add_feedback.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_add_bottom_sheet.dart';
import 'package:mybeshop/features/main/prenestation/widgets/product/product_add_utils.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_select_widget.dart';

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

Widget addToCartButton(
  Product product, {
  height = 140,
  width = double.infinity,
}) {
  return GetBuilder<MainController>(
    builder: (_) {
      return GetBuilder<CartController>(
        builder: (cart) {
          final inCart = isProductInCart(product);
          final loading = cart.productSelectedLoading.value &&
              product == cart.selectedProduct;

          return MaterialButton(
            height: height,
            clipBehavior: Clip.none,
            disabledColor: AppTheme.to.primaryColor.withOpacity(0.4),
            onPressed: loading
                ? null
                : () async {
                    if (inCart) {
                      openCartTab();
                      return;
                    }
                    await addToCartAction(product);
                  },
            minWidth: width,
            color: inCart
                ? AppTheme.to.successColor
                : AppTheme.to.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: loading
                ? SizedBox(
                    width: 22.h,
                    height: 22.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: inCart
                          ? Colors.white
                          : AppTheme.to.onPrimaryColor,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        inCart
                            ? LineAwesomeIcons.check_circle
                            : LineAwesomeIcons.shopping_cart,
                        size: 16.sp,
                        color: inCart
                            ? Colors.white
                            : AppTheme.to.onPrimaryColor,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        inCart ? 'in_cart'.tr : 'add_to_cart'.tr,
                        style: AppStyles.bodyBoldM.copyWith(
                          color: inCart
                              ? Colors.white
                              : AppTheme.to.onPrimaryColor,
                        ),
                      ),
                    ],
                  ),
          );
        },
      );
    },
  );
}

Widget addToCartMobileButton(Product product) {
  return _ProductAddMobileButton(product: product);
}

class _ProductAddMobileButton extends StatefulWidget {
  const _ProductAddMobileButton({required this.product});

  final Product product;

  @override
  State<_ProductAddMobileButton> createState() =>
      _ProductAddMobileButtonState();
}

class _ProductAddMobileButtonState extends State<_ProductAddMobileButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseScale;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _pulseScale = Tween<double>(begin: 1, end: 1.14).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    final product = widget.product;
    if (isProductInCart(product)) {
      openCartTab();
      return;
    }
    if (canQuickAdd(product)) {
      final added = await quickAddBasicProduct(product);
      if (added && mounted) {
        await _pulseController.forward(from: 0);
        _pulseController.reverse();
      }
      return;
    }
    await showProductAddSheet(product);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (_) {
        return GetBuilder<CartController>(
          builder: (cart) {
            final product = widget.product;
            final inCart = isProductInCart(product);
            final loading = cart.productSelectedLoading.value &&
                product == cart.selectedProduct;
            final adding = cart.isAddingToCart.value &&
                product == cart.selectedProduct;

            final bgColor =
                inCart ? AppTheme.to.successColor : AppTheme.to.primaryColor;
            final iconColor =
                inCart ? Colors.white : AppTheme.to.onPrimaryColor;

            return ScaleTransition(
              scale: _pulseScale,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: (loading || adding) ? null : _handleTap,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    width: 44.h,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: bgColor.withOpacity(0.35),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: loading || adding
                        ? Padding(
                            padding: EdgeInsets.all(10.r),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: iconColor,
                            ),
                          )
                        : Icon(
                            inCart
                                ? LineAwesomeIcons.check
                                : LineAwesomeIcons.plus,
                            color: iconColor,
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

addToCartAction(Product product) async {
  await CartController.to.onProductSelected(product);
  bool canAdd = checkCanAdd(product);
  bool isInCart = checkIsInCart(product);

  // log("CAN ADD = ${checkCanAdd(product)}");
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
                            child: AppNetworkImage(imageUrl: product.type == "basic"
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
                              RiyalPriceText(
                                amount: product.price!,
                                currency: product.currency,
                                style: AppStyles.bodyBoldL.copyWith(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              if (product.hasDiscount ?? false) ...[
                                RiyalPriceText(
                                  amount: product.originalPrice!,
                                  currency: product.currency,
                                  style: AppStyles.bodyMediumM.copyWith(
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.red,
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
                                                  RiyalPriceText(
                                                    amount: extra.priceFormatted,
                                                    formatted: true,
                                                    style: AppStyles.bodyMediumS,
                                                  ),
                                                  if (extra.hasDiscount) ...[
                                                    SizedBox(width: 10.w),
                                                    RiyalPriceText(
                                                      amount: extra
                                                          .originalPriceFormatted,
                                                      formatted: true,
                                                      style: AppStyles.bodyMediumS
                                                          .copyWith(
                                                        color: Colors.red,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
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
                                : CartController.to.variantDetails?.qty ?? 0,
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
                                      TextSpan(text: '${'final_price'.tr} '),
                                      RiyalFormatter.buildPriceSpan(
                                        RiyalFormatter.format(
                                          amount: getTotalPriceAsText(product),
                                          currency: product.currency,
                                        ),
                                        AppStyles.bodyBoldM
                                            .copyWith(color: Colors.red),
                                      ),
                                    ],
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
                                    final itemId = CartController
                                        .to.shoppingCart?.items
                                        .firstWhere((element) =>
                                            element.productId == product.id)
                                        .id;
                                    if (itemId != null) {
                                      CartController.to.deleteItemFromCart(
                                          itemId,
                                          withBack: true);
                                      markProductInCartState(product,
                                          inCart: false);
                                    }
                                  } else {
                                    final added =
                                        await CartController.to.addToCart();
                                    if (added) {
                                      Get.back();
                                      onProductAddedSuccessfully(product);
                                    }
                                  }
                                } else {
                                  if (isInCart) {
                                    final itemId = CartController
                                        .to.shoppingCart?.items
                                        .firstWhere((element) =>
                                            element.productId ==
                                            CartController
                                                .to.variantDetails!.id)
                                        .id;
                                    if (itemId != null) {
                                      CartController.to.deleteItemFromCart(
                                          itemId,
                                          withBack: true);
                                    }
                                  } else {
                                    final added =
                                        await CartController.to.addToCart();
                                    if (added) {
                                      Get.back();
                                      onProductAddedSuccessfully(product);
                                    }
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
                                  color: AppTheme.to.onPrimaryColor,
                                ),
                              )
                            : canAdd
                                ? CartController.to.isAddingToCart.value
                                    ? SizedBox(
                                        width: 100.h,
                                        height: 100.h,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: AppTheme.to.onPrimaryColor,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        "add_to_cart".tr,
                                        style: AppStyles.bodyBoldL.copyWith(
                                          color: AppTheme.to.onPrimaryColor,
                                        ),
                                      )
                                : Text(
                                    "out_of_stock".tr,
                                    style: AppStyles.bodyBoldL.copyWith(
                                      color: AppTheme.to.onPrimaryColor,
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
