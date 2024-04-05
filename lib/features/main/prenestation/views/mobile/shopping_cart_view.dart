import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/app_dialogs.dart';
import 'package:mybeshop/features/main/domain/entities/cart_item.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/mobile/custom_divider.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: AppTheme.to.primaryColor,
          title: Text(
            "shopping_cart".tr,
            style: AppStyles.bodyBoldM.copyWith(color: Colors.white),
          ),
        ),
        body: controller.shopingCartLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    if (controller.shoppingCart != null &&
                        controller.shoppingCart!.items.isNotEmpty) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: TextButton(
                          onPressed: () {
                            controller.clearShoppingCart();
                          },
                          child: Text(
                            "clear_shopping_cart".tr,
                            style: AppStyles.bodyMediumM
                                .copyWith(color: AppTheme.to.primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                    ListView.separated(
                      itemBuilder: (context, index) {
                        CartItem item = controller.shoppingCart!.items[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Row(
                            children: [
                              Container(
                                width: 110.h,
                                height: 110.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.r),
                                  color: AppTheme.to.greyColor.withOpacity(0.2),
                                ),
                                child: Image.network(
                                  item.image ??
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
                                      item.name,
                                      style: AppStyles.bodyMediumM,
                                    ),
                                    if (item.extras.isNotEmpty) ...[
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        height: 34.h,
                                        child: ScrollConfiguration(
                                          behavior:
                                              const MaterialScrollBehavior()
                                                  .copyWith(
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
                                              for (ProductExtra extra
                                                  in item.extras)
                                                InkWell(
                                                  onTap: () {
                                                    Get.dialog(
                                                        AppDialogs.customDialog(
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
                                                        CartController.to
                                                            .deleteItemFromCart(
                                                                item.id,
                                                                extraId:
                                                                    extra.id);
                                                      },
                                                    ));
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3.w),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3.w,
                                                            vertical: 1.h),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: AppTheme
                                                            .to.primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.r)),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          extra.name,
                                                          style: AppStyles
                                                              .bodyRegularS
                                                              .copyWith(
                                                                  fontSize:
                                                                      8.sp,
                                                                  color: Colors
                                                                      .white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Directionality(
                                                          textDirection:
                                                              TextDirection.ltr,
                                                          child: Text(
                                                            extra
                                                                .priceFormatted,
                                                            style: AppStyles
                                                                .bodyRegularS
                                                                .copyWith(
                                                                    fontSize:
                                                                        8.sp,
                                                                    color: Colors
                                                                        .white),
                                                            textAlign: TextAlign
                                                                .center,
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
                                    Text(
                                      item.priceFormatted,
                                      style: AppStyles.bodyMediumM,
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            CartController.to.updateCart(item,
                                                isIncrease: false);
                                          },
                                          child: Container(
                                            width: 25.h,
                                            height: 25.h,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1.w, vertical: 1.h),
                                            decoration: BoxDecoration(
                                              color: AppTheme.to.primaryColor
                                                  .withOpacity(0.8),
                                            ),
                                            child: Icon(
                                              LineAwesomeIcons.minus,
                                              color: Colors.white,
                                              size: 15.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 3.w),
                                        Text("${item.qty}",
                                            style: AppStyles.bodyBoldXL),
                                        SizedBox(width: 3.w),
                                        InkWell(
                                          onTap: () {
                                            CartController.to.updateCart(item,
                                                isIncrease: true);
                                          },
                                          child: Container(
                                            width: 25.h,
                                            height: 25.h,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1.w, vertical: 1.h),
                                            decoration: BoxDecoration(
                                              color: AppTheme.to.primaryColor
                                                  .withOpacity(0.8),
                                            ),
                                            child: Icon(
                                              LineAwesomeIcons.plus,
                                              color: Colors.white,
                                              size: 15.sp,
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
                                  CartController.to.deleteItemFromCart(item.id);
                                },
                                visualDensity: const VisualDensity(
                                    horizontal: -3, vertical: -3),
                                icon: Icon(
                                  LineAwesomeIcons.trash,
                                  size: 30.sp,
                                ),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          controller.shoppingCart!.items.length - 1 != index
                              ? const CustomDivider()
                              : const SizedBox.shrink(),
                      itemCount: controller.shoppingCart!.items.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ],
                ),
              ),
        bottomSheet: controller.shopingCartLoading.value == false &&
                (controller.shoppingCart != null &&
                    controller.shoppingCart!.items.isNotEmpty)
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                height: 85.h,
                decoration: BoxDecoration(color: Colors.grey.shade50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "sub_total".tr,
                                style: AppStyles.bodyMediumS,
                              ),
                              Text(
                                controller.shoppingCart!.subTotalFotmatted,
                                style: AppStyles.bodyMediumS,
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          const Divider(),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "tax".tr,
                                style: AppStyles.bodyMediumS,
                              ),
                              Text(
                                controller.shoppingCart!.taxFormatted,
                                style: AppStyles.bodyMediumS,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    const VerticalDivider(),
                    SizedBox(
                      width: 10.w,
                    ),
                    MaterialButton(
                      height: 50.h,
                      minWidth: 130.w,
                      onPressed: () {
                        Get.toNamed(AppRoutes.checkout);
                      },
                      color: AppTheme.to.primaryColor,
                      child: Text(
                        "checkout".tr,
                        style: AppStyles.bodySemiBoldM
                            .copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            : null,
      );
    });
  }
}
