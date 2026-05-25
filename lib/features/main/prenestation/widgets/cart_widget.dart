import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/app_dialogs.dart';
import 'package:mybeshop/core/utils/helper/app_shimmer_loader.dart';
import 'package:mybeshop/features/main/domain/entities/cart_item.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: Get.find<CartController>(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: (controller.shoppingCart != null &&
                                controller.shoppingCart!.items.isNotEmpty)
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          Text(
                            "shopping_cart".tr,
                            style: AppStyles.heading5,
                          ),
                          if (controller.shoppingCart != null &&
                              controller.shoppingCart!.items.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                controller.clearShoppingCart();
                              },
                              child: Text(
                                "clear_shopping_cart".tr,
                                style: AppStyles.bodyBoldL.copyWith(
                                  color: AppTheme.to.primaryColor,
                                ),
                              ),
                            )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      const Divider(),
                      SizedBox(height: 90.h),
                      if (controller.shopingCartLoading.value)
                        ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                AppShimmerLoader.showShimmerLoader(
                                  width: double.infinity,
                                  height: 280.h,
                                  borderRadius: 12,
                                  bottomMargin: 20.h,
                                ))
                      else if (controller.shoppingCart == null ||
                          (controller.shoppingCart != null &&
                              controller.shoppingCart!.items.isEmpty))
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Lottie.asset(
                                    "assets/lotties/empty_cart.json",
                                    height: 400.h),
                              ),
                              SizedBox(height: 20.h),
                              Text("your_cart_is_empty".tr,
                                  style: AppStyles.bodyMediumXL),
                            ],
                          ),
                        )
                      else
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.shoppingCart!.items.length,
                            itemBuilder: (context, index) =>
                                CartProductCardWidget(
                                    cartItem:
                                        controller.shoppingCart!.items[index]))
                      // CartProductCardWidget(),
                      // CartProductCardWidget(),
                      // CartProductCardWidget(),
                      // CartProductCardWidget(),
                      // CartProductCardWidget(),
                      // CartProductCardWidget(),
                      // CartProductCardWidget(),
                    ]),
                if (controller.shopingCartLoading.value == false &&
                    (controller.shoppingCart != null &&
                        controller.shoppingCart!.items.isNotEmpty)) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "sub_total".tr,
                                style: AppStyles.bodyBoldL,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  "${controller.shoppingCart?.subTotalFotmatted}",
                                  style: AppStyles.bodyBoldL,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 25.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "tax".tr,
                                style: AppStyles.bodyBoldL,
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Text(
                                  "${controller.shoppingCart?.taxFormatted}",
                                  style: AppStyles.bodyBoldL,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          MaterialButton(
                            minWidth: double.infinity,
                            color: AppTheme.to.primaryColor,
                            height: 150.h,
                            onPressed: () {
                              Get.toNamed(AppRoutes.checkout);
                            },
                            child: Text(
                              "checkout".tr,
                              style: AppStyles.bodyBoldL
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        ]),
                  )
                ],
              ],
            ),
          );
        });
  }
}

class CartProductCardWidget extends StatelessWidget {
  const CartProductCardWidget({
    super.key,
    required this.cartItem,
  });
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 250.h,
              width: 100.w,
              decoration:
                  BoxDecoration(color: AppTheme.to.greyColor.withOpacity(0.3)),
              child: Image.network(
                cartItem.image ??
                    "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.name,
                    style: AppStyles.heading5.copyWith(fontSize: 16.sp),
                  ),
                  if (cartItem.extras.isNotEmpty) ...[
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 55.h,
                      child: ScrollConfiguration(
                        behavior: const MaterialScrollBehavior().copyWith(
                          dragDevices: {
                            PointerDeviceKind.mouse,
                            PointerDeviceKind.touch,
                            PointerDeviceKind.stylus,
                            PointerDeviceKind.unknown
                          },
                        ),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            for (ProductExtra extra in cartItem.extras)
                              InkWell(
                                onTap: () {
                                  Get.dialog(AppDialogs.customDialog(
                                    isLottie: true,
                                    isLooping: false,
                                    icon: "delete.json",
                                    title: "warning".tr,
                                    okButtonText: "yes".tr,
                                    cancelText: "no".tr,
                                    message:
                                        "are_you_sure_this_extra_will_be_deleted"
                                            .tr,
                                    showCancelButton: true,
                                    onPressed: () {
                                      Get.back();
                                      CartController.to.deleteItemFromCart(
                                          cartItem.id,
                                          extraId: extra.id);
                                    },
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 1.h),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppTheme.to.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: Column(
                                    children: [
                                      Text(
                                        extra.name,
                                        style: AppStyles.bodyBoldS.copyWith(
                                            fontSize: 9.sp,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          extra.priceFormatted,
                                          style: AppStyles.bodyBoldS.copyWith(
                                              fontSize: 9.sp,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 8.h),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      cartItem.priceFormatted,
                      style: AppStyles.heading3.copyWith(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          CartController.to
                              .updateCart(cartItem, isIncrease: false);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: AppTheme.to.primaryColor.withOpacity(0.8),
                          ),
                          child: Icon(
                            LineAwesomeIcons.minus,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Text("${cartItem.qty}", style: AppStyles.bodyBoldXL),
                      SizedBox(width: 3.w),
                      InkWell(
                        onTap: () {
                          CartController.to
                              .updateCart(cartItem, isIncrease: true);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 55.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: AppTheme.to.primaryColor.withOpacity(0.8),
                          ),
                          child: Icon(
                            LineAwesomeIcons.plus,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                CartController.to.deleteItemFromCart(cartItem.id);
              },
              visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
              icon: Icon(
                LineAwesomeIcons.trash,
                size: 30.sp,
              ),
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 5),
        const Divider()
      ],
    );
  }
}
