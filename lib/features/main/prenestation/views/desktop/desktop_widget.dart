import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/app_shimmer_loader.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/domain/entities/product_extra.dart';
import 'package:mybeshop/features/main/domain/entities/variant_option.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/views/desktop/checkout_view.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_select_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({
    super.key,
    required GlobalKey<ScaffoldState> skey,
  }) : _key = skey;

  final GlobalKey<ScaffoldState> _key;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MainController(Get.find(), Get.find()),
        builder: (controller) {
          return Scaffold(
              key: _key,
              body: GlobalController.to.isLoading.value
                  ? Center(
                      child: Lottie.asset("assets/lotties/loader.json",
                          height: 400),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 310.w, vertical: 47.5.h),
                            decoration:
                                BoxDecoration(color: AppTheme.to.primaryColor),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        NavBarSocialMediaButtonWidget(
                                          icon: LineAwesomeIcons.facebook_f,
                                          onPressed: () {
                                            if (GlobalController.to.storeInfo
                                                    ?.social["facebook"] !=
                                                null) {
                                              launchUrlString(GlobalController
                                                  .to
                                                  .storeInfo!
                                                  .social["facebook"]!);
                                            }
                                          },
                                        ),
                                        NavBarSocialMediaButtonWidget(
                                          icon: LineAwesomeIcons.twitter,
                                          onPressed: () {
                                            if (GlobalController.to.storeInfo
                                                    ?.social["twitter"] !=
                                                null) {
                                              launchUrlString(GlobalController
                                                  .to
                                                  .storeInfo!
                                                  .social["twitter"]!);
                                            }
                                          },
                                        ),
                                        NavBarSocialMediaButtonWidget(
                                          icon: LineAwesomeIcons.snapchat,
                                          onPressed: () {
                                            if (GlobalController.to.storeInfo
                                                    ?.social["snapchat"] !=
                                                null) {
                                              launchUrlString(GlobalController
                                                  .to
                                                  .storeInfo!
                                                  .social["snapchat"]!);
                                            }
                                          },
                                        ),
                                        NavBarSocialMediaButtonWidget(
                                          icon: LineAwesomeIcons.what_s_app,
                                          onPressed: () {
                                            if (GlobalController.to.storeInfo
                                                    ?.social["whatsapp"] !=
                                                null) {
                                              launchUrlString(GlobalController
                                                  .to
                                                  .storeInfo!
                                                  .social["whatsapp"]!);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        MaterialButton(
                                          minWidth: 180.w,
                                          elevation: 0,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero),
                                          onPressed: () {},
                                          color: AppTheme.to.yellowColor,
                                          child: Text(
                                            "discover_now".tr,
                                            style: AppStyles.bodyBoldL.copyWith(
                                                color: AppTheme.to.primaryColor,
                                                height: 5.h),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Get.toNamed(AppRoutes.settings);
                                            GlobalController.to
                                                .changeCurrentLanguage(
                                                    GlobalController
                                                                .to
                                                                .currentLocale
                                                                .languageCode ==
                                                            "ar"
                                                        ? "en"
                                                        : "ar");
                                          },
                                          child: Text(
                                            GlobalController.to.currentLocale
                                                        .languageCode ==
                                                    "ar"
                                                ? "english".tr
                                                : "arabic".tr,
                                            style: AppStyles.bodyMediumL
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SelectionArea(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 34.w,
                                                  height: 3.h,
                                                  decoration: BoxDecoration(
                                                      color: AppTheme
                                                          .to.yellowColor),
                                                ),
                                                SizedBox(width: 10.w),
                                                Text(
                                                  "welcome_to".tr,
                                                  style: AppStyles.heading3
                                                      .copyWith(
                                                          color: Colors.white,
                                                          height: 5.h,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16.h),
                                            Text(
                                              "${GlobalController.to.storeInfo?.heroTitle}",
                                              style: AppStyles.heading3
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 50.sp,
                                                      height: 4.5.h,
                                                      color: Colors.white),
                                            ),
                                            SizedBox(height: 32.h),
                                            Text(
                                              "${GlobalController.to.storeInfo?.bio}",
                                              style: AppStyles.bodyRegularXL
                                                  .copyWith(
                                                color: Colors.white,
                                                height: 7.h,
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 16.w,
                                                          width: 16.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppTheme
                                                                .to.yellowColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.r),
                                                          ),
                                                        ),
                                                        SizedBox(width: 13.w),
                                                        Text(
                                                          "contact_information"
                                                              .tr,
                                                          style: AppStyles
                                                              .heading4
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  height: 5.h),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    HeroInfoItem(
                                                        onPressed: () {
                                                          if (GlobalController
                                                                  .to
                                                                  .storeInfo
                                                                  ?.phone !=
                                                              null) {
                                                            launchUrlString(
                                                                "tel:${GlobalController.to.storeInfo?.phone}");
                                                          }
                                                        },
                                                        text:
                                                            "${GlobalController.to.storeInfo?.phone}",
                                                        icon: LineAwesomeIcons
                                                            .phone),
                                                    const SizedBox(height: 3),
                                                    HeroInfoItem(
                                                        onPressed: () {
                                                          if (GlobalController
                                                                  .to
                                                                  .storeInfo
                                                                  ?.email !=
                                                              null) {
                                                            launchUrlString(
                                                                "mailto:${GlobalController.to.storeInfo?.email}");
                                                          }
                                                        },
                                                        text:
                                                            "${GlobalController.to.storeInfo?.email}",
                                                        icon: LineAwesomeIcons
                                                            .envelope),
                                                    const SizedBox(height: 3),
                                                    HeroInfoItem(
                                                        text:
                                                            "${GlobalController.to.storeInfo?.address}",
                                                        icon: LineAwesomeIcons
                                                            .map_marker),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 16.w,
                                                          width: 16.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppTheme
                                                                .to.yellowColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.r),
                                                          ),
                                                        ),
                                                        SizedBox(width: 13.w),
                                                        Text(
                                                          "working_hours".tr,
                                                          style: AppStyles
                                                              .heading4
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  height: 5.h),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    HeroInfoItem(
                                                        text:
                                                            "${GlobalController.to.storeInfo?.workingHours}",
                                                        icon: LineAwesomeIcons
                                                            .clock),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 95.w),
                                      Expanded(
                                        child: Image.asset(
                                          "assets/images/bg.png",
                                          height: 750.h,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 310.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "categories".tr,
                                        style: AppStyles.bodyBoldXL
                                            .copyWith(color: Colors.black45),
                                      ),
                                      SizedBox(height: 25.h),
                                      Column(
                                        children: [
                                          if (controller
                                              .categoriesLoading.value)
                                            ListView.builder(
                                                itemCount: 10,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    AppShimmerLoader
                                                        .showShimmerLoader(
                                                      width: double.infinity,
                                                      height: 120.h,
                                                      borderRadius: 12,
                                                      bottomMargin: 20.h,
                                                    ))
                                          else
                                            for (Category category
                                                in controller.categories)
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: controller.selectedCategory != null &&
                                                            controller.selectedCategory?.id ==
                                                                category.id
                                                        ? Border(
                                                            left: GlobalController
                                                                        .to
                                                                        .currentLocale
                                                                        .languageCode ==
                                                                    "en"
                                                                ? BorderSide(
                                                                    width: 5.w,
                                                                    color: AppTheme
                                                                        .to
                                                                        .yellowColor)
                                                                : BorderSide
                                                                    .none,
                                                            right: GlobalController
                                                                        .to
                                                                        .currentLocale
                                                                        .languageCode ==
                                                                    "ar"
                                                                ? BorderSide(width: 5.w, color: AppTheme.to.yellowColor)
                                                                : BorderSide.none)
                                                        : null,
                                                    color: AppTheme.to.yellowColor.withOpacity(0.1)),

                                                margin: const EdgeInsets.only(
                                                    bottom: 8),
                                                // Align to the start (left)

                                                child: InkWell(
                                                  onTap: () {
                                                    controller
                                                        .onCategorySelected(
                                                            category);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          category.name,
                                                          style: AppStyles
                                                              .bodyBoldL,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        Text(
                                                          "${category.productsCount}",
                                                          style: AppStyles
                                                              .bodyBoldL,
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 32.w,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                  text:
                                                      "${"filtered_by".tr} :"),
                                              TextSpan(
                                                  text: controller
                                                              .selectedCategory !=
                                                          null
                                                      ? " ${controller.selectedCategory?.name}"
                                                      : " ${"none".tr}"),
                                            ]),
                                            style: AppStyles.bodyBoldL,
                                          ),
                                          InkWell(
                                            onTap: () => controller
                                                .changeProductsLayout(),
                                            child: controller.isGrid
                                                ? const Icon(
                                                    LineAwesomeIcons.th_large,
                                                  )
                                                : const Icon(
                                                    LineAwesomeIcons.list),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      productCard(isGrid: controller.isGrid),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 32.w,
                                ),
                                const Expanded(
                                  flex: 2,
                                  child: CartWidget(),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 200.h),
                        ],
                      ),
                    ));
        });
  }
}

Widget productCard({
  isGrid = false,
}) {
  return GetBuilder(
      init: CartController.to,
      builder: (_) {
        if (isGrid) {
          return Get.find<MainController>().categoriesLoading.value
              ? GridView.builder(
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 0.90),
                  itemBuilder: (context, index) =>
                      AppShimmerLoader.showShimmerLoader(
                          borderRadius: 12,
                          leftMargin: 12,
                          topMargin: 12,
                          bottomMargin: 12,
                          rightMargin: 12),
                )
              : Get.find<MainController>().selectedCategory!.products.isEmpty
                  ? const EmptyProductsWidget()
                  : GridView.builder(
                      primary: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Get.find<MainController>()
                          .selectedCategory!
                          .products
                          .length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return HorizontalProductCardWidget(
                            product: Get.find<MainController>()
                                .selectedCategory!
                                .products[index]);
                      },
                    );
        } else {
          return Get.find<MainController>().categoriesLoading.value
              ? ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      AppShimmerLoader.showShimmerLoader(
                    width: double.infinity,
                    height: 280.h,
                    borderRadius: 12,
                    bottomMargin: 30.h,
                  ),
                )
              : Get.find<MainController>().selectedCategory!.products.isEmpty
                  ? const EmptyProductsWidget()
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return VerticalProductCardWidget(
                            product: Get.find<MainController>()
                                .selectedCategory!
                                .products[index]);
                      },
                      itemCount: Get.find<MainController>()
                          .selectedCategory!
                          .products
                          .length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    );
        }
      });
}

class EmptyProductsWidget extends StatelessWidget {
  const EmptyProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset("assets/lotties/empty_products.json"),
        ),
        SizedBox(height: 20.h),
        Text(
          "no_products_to_show".tr,
          style: AppStyles.bodyMediumL,
        ),
      ],
    );
  }
}

class VerticalProductCardWidget extends StatelessWidget {
  const VerticalProductCardWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(bottom: 30.h),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: 130.w,
                width: 130.w,
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: Image.network(
                  product.images.isNotEmpty
                      ? product.images[0]
                      : "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png",
                  fit: BoxFit.cover,
                ),
              ),
              if (product.hasDiscount != null && product.hasDiscount!)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
                    decoration: const BoxDecoration(color: Colors.red),
                    child: Text(
                      "${product.discountPercent}%",
                      style:
                          AppStyles.bodyMediumL.copyWith(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppStyles.bodyBoldL,
                ),
                if (product.description != null) ...[
                  SizedBox(height: 2.w),
                  Text(
                    "${product.description}",
                    style: AppStyles.bodyRegularS,
                    maxLines: 2,
                  ),
                ],
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      "${product.price} ${product.currency}",
                      style: AppStyles.bodyBoldL,
                    ),
                    if (product.hasDiscount != null &&
                        product.hasDiscount!) ...[
                      SizedBox(width: 10.w),
                      Text(
                        "${product.originalPrice}",
                        style: AppStyles.bodyMediumM.copyWith(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ]
                  ],
                ),
                if (getHasExtrasOrVariantsText(product) != null) ...[
                  SizedBox(height: 5.h),
                  Text(
                    getHasExtrasOrVariantsText(product)!,
                    style: AppStyles.bodyMediumM
                        .copyWith(color: AppTheme.to.greyColor),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: 10.w),

          addToCartButton(product, height: double.infinity, width: null)

          // Text(
          //   "100.00 SAR",
          //   style: AppStyles.bodyBoldL,
          // )
        ],
      ),
    );
  }
}

class HorizontalProductCardWidget extends StatelessWidget {
  const HorizontalProductCardWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      width: 50.w,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          product.images.isNotEmpty
                              ? product.images[0]
                              : "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png",
                          height: 300.h,
                        ),
                      ),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.heading5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // if (product.type == "basic")
                      Row(
                        children: [
                          Text(
                            "${product.price!} ${product.currency}",
                            style: AppStyles.bodyBoldL.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          if (product.hasDiscount ?? false) ...[
                            Text(
                              product.originalPrice!,
                              style: AppStyles.bodyMediumM.copyWith(
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.red),
                            ),
                          ]
                        ],
                      ),

                      if (getHasExtrasOrVariantsText(product) != null) ...[
                        SizedBox(height: 10.h),
                        Text(
                          getHasExtrasOrVariantsText(product)!,
                          style: AppStyles.bodyMediumM
                              .copyWith(color: AppTheme.to.greyColor),
                        ),
                      ],
                    ]),
              ),
              if (product.hasDiscount != null && product.hasDiscount!)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                    decoration: const BoxDecoration(color: Colors.red),
                    child: Text(
                      "${product.discountPercent}%",
                      style:
                          AppStyles.bodyMediumL.copyWith(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          addToCartButton(
            product,
            height: 140.h,
          )
        ],
      ),
    );
  }
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
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      width: double.infinity,
                                      height: 300.w,
                                      child: Image.network(
                                        product.type == "basic"
                                            ? (product.images.isNotEmpty
                                                ? product.images[0]
                                                : "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png")
                                            : CartController
                                                    .to.variantDetails!.image ??
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
                                        product.description!,
                                        style: AppStyles.bodyRegularS,
                                      ),
                                    ],
                                    SizedBox(height: 10.h),
                                    Row(
                                      children: [
                                        Text(
                                          "${product.price!} ${product.currency}",
                                          style: AppStyles.bodyBoldL.copyWith(
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        if (product.hasDiscount ?? false) ...[
                                          Text(
                                            product.originalPrice!,
                                            style: AppStyles.bodyMediumM
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.red),
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
                                                  await Get.find<
                                                          CartController>()
                                                      .onOptionSelected(v);
                                                  state(() {
                                                    canAdd =
                                                        checkCanAdd(product);
                                                    isInCart =
                                                        checkIsInCart(product);
                                                  });
                                                },
                                                items: variantOption.options
                                                    .map((e) =>
                                                        DropdownMenuEntry(
                                                            value: e,
                                                            label: e.name))
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
                                            for (ProductExtra extra
                                                in product.extras)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 20.w,
                                                      width: 20.w,
                                                      child: Checkbox(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.w)),
                                                        visualDensity:
                                                            const VisualDensity(
                                                                horizontal: -3,
                                                                vertical: -3),
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .padded,
                                                        value: CartController
                                                            .to.extras
                                                            .contains(extra),
                                                        onChanged: (v) {
                                                          state(() {
                                                            CartController.to
                                                                .onExtraSelected(
                                                                    extra);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(width: 10.w),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          extra.name,
                                                          style: AppStyles
                                                              .bodyMediumM,
                                                        ),
                                                        SizedBox(height: 10.h),
                                                        Text(
                                                          extra
                                                              .originalPriceFormatted,
                                                          style: AppStyles
                                                              .bodyMediumS
                                                              .copyWith(
                                                            color: AppTheme.to
                                                                .primaryColor,
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
                                          : CartController
                                                  .to.variantDetails!.qty ??
                                              0,
                                      initVal: CartController.to.qty,
                                      minVal: 1,
                                      steps: 1,
                                      decoration: QtyDecorationProps(
                                          btnColor: AppTheme.to.primaryColor),
                                      qtyFormProps: QtyFormProps(
                                          style: AppStyles.bodyMediumXL),
                                      onQtyChanged: (val) =>
                                          CartController.to.onQtyChanged(val),
                                    ),

                                    SizedBox(height: 30.h),
                                    CartController.to
                                            .variantProductDetailsLoading.value
                                        ? Text(
                                            "loading".tr,
                                            style: AppStyles.bodyBoldM,
                                          )
                                        : Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text:
                                                        "${"final_price".tr} "),
                                                TextSpan(
                                                  text: getTotalPriceAsText(
                                                      product),
                                                ),
                                                TextSpan(
                                                  text: " ${product.currency}",
                                                  style: const TextStyle(
                                                      color: Colors.red),
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
                                          CartController
                                              .to.isAddingToCart.value)
                                      ? null
                                      : () async {
                                          if (product.type == "basic") {
                                            if (isInCart) {
                                              CartController.to
                                                  .deleteItemFromCart(
                                                      CartController.to
                                                          .shoppingCart?.items
                                                          .firstWhere((element) =>
                                                              element
                                                                  .productId ==
                                                              product.id)
                                                          .id,
                                                      withBack: true);
                                              product.inCart = false;
                                            } else {
                                              await CartController.to
                                                  .addToCart();
                                              Get.back();
                                              product.inCart = true;
                                            }
                                          } else {
                                            if (isInCart) {
                                              CartController.to.deleteItemFromCart(
                                                  CartController
                                                      .to.shoppingCart?.items
                                                      .firstWhere((element) =>
                                                          element.productId ==
                                                          CartController
                                                              .to
                                                              .variantDetails!
                                                              .id)
                                                      .id,
                                                  withBack: true);
                                            } else {
                                              await CartController.to
                                                  .addToCart();
                                              Get.back();

                                              CartController.to.variantDetails!
                                                  .inCart = true;
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
                                          ? CartController
                                                  .to.isAddingToCart.value
                                              ? SizedBox(
                                                  width: 100.h,
                                                  height: 100.h,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0),
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 3,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  "add_to_cart".tr,
                                                  style: AppStyles.bodyBoldL
                                                      .copyWith(
                                                          color: Colors.white),
                                                )
                                          : Text(
                                              "out_of_stock".tr,
                                              style:
                                                  AppStyles.bodyBoldL.copyWith(
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

class ColorVariantWidget extends StatelessWidget {
  const ColorVariantWidget({
    required this.color,
    super.key,
  });
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(30.w),
      ),
      child: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.w),
        ),
      ),
    );
  }
}

class HeroInfoItem extends StatelessWidget {
  const HeroInfoItem({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
  });
  final IconData icon;
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            text,
            style: AppStyles.bodyRegularXL
                .copyWith(color: Colors.white, height: 5.h),
          ),
        ],
      ),
    );
  }
}

class NavBarSocialMediaButtonWidget extends StatelessWidget {
  const NavBarSocialMediaButtonWidget(
      {super.key, required this.icon, this.onPressed});
  final IconData icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      width: 45.w,
      height: 45.w,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: InkWell(
          onTap: onPressed,
          child: Icon(
            icon,
            size: 24.sp,
            color: AppTheme.to.primaryColor,
          )),
    );
  }
}
