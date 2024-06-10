import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/app_shimmer_loader.dart';
import 'package:mybeshop/core/utils/helper/extenstions.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/domain/entities/category.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/prenestation/controllers/cart_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/cart_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/empty_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/navbar_social_media_buttons_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/shared_widgets_and_methods.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({
    super.key,
    required GlobalKey<ScaffoldState> skey,
  }) : _key = skey;

  final GlobalKey<ScaffoldState> _key;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1920, 2720),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
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
                                  decoration: BoxDecoration(
                                      color: AppTheme.to.primaryColor),
                                  child: Row(
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
                                            icon: LineAwesomeIcons.instagram,
                                            onPressed: () {
                                              if (GlobalController.to.storeInfo
                                                      ?.social["instagram"] !=
                                                  null) {
                                                launchUrlString(GlobalController
                                                    .to
                                                    .storeInfo!
                                                    .social["instagram"]!);
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
                                      SizedBox(width: 95.w),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 180.w,
                                              vertical: 47.5.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    children: [
                                                      if (GlobalController.to
                                                                  .storeInfo !=
                                                              null &&
                                                          GlobalController
                                                              .to
                                                              .storeInfo!
                                                              .ordersTrackingEnabled)
                                                        MaterialButton(
                                                          minWidth: 180.w,
                                                          elevation: 0,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .zero),
                                                          onPressed: () {
                                                            Get.toNamed(AppRoutes
                                                                .trackOrders);
                                                          },
                                                          color: AppTheme
                                                              .to.yellowColor,
                                                          child: Text(
                                                            "track_orders".tr,
                                                            style: AppStyles
                                                                .bodyBoldL
                                                                .copyWith(
                                                                    color: AppTheme
                                                                        .to
                                                                        .primaryColor,
                                                                    height:
                                                                        5.h),
                                                            textAlign: TextAlign
                                                                .center,
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
                                                          GlobalController
                                                                      .to
                                                                      .currentLocale
                                                                      .languageCode ==
                                                                  "ar"
                                                              ? "english".tr
                                                              : "arabic".tr,
                                                          style: AppStyles
                                                              .bodyMediumL
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
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
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                width: 34.w,
                                                                height: 3.h,
                                                                decoration: BoxDecoration(
                                                                    color: AppTheme
                                                                        .to
                                                                        .yellowColor),
                                                              ),
                                                              SizedBox(
                                                                  width: 10.w),
                                                              Text(
                                                                "welcome_to".tr,
                                                                style: AppStyles
                                                                    .heading3
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white,
                                                                        height:
                                                                            5.h,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: 16.h),
                                                          Text(
                                                            "${GlobalController.to.storeInfo?.heroTitle}",
                                                            style: AppStyles
                                                                .heading3
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        50.sp,
                                                                    height:
                                                                        4.5.h,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                          SizedBox(
                                                              height: 32.h),
                                                          if (GlobalController
                                                                  .to
                                                                  .storeInfo
                                                                  ?.bio !=
                                                              null) ...[
                                                            Text(
                                                              "${GlobalController.to.storeInfo?.bio.removeHtmlTags()}",
                                                              style: AppStyles
                                                                  .bodyRegularXL
                                                                  .copyWith(
                                                                color: Colors
                                                                    .white,
                                                                height: 7.h,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 50.h),
                                                          ],
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            16.w,
                                                                        width:
                                                                            16.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: AppTheme
                                                                              .to
                                                                              .yellowColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.r),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              13.w),
                                                                      Text(
                                                                        "contact_information"
                                                                            .tr,
                                                                        style: AppStyles.heading4.copyWith(
                                                                            color:
                                                                                Colors.white,
                                                                            height: 5.h),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  HeroInfoItem(
                                                                      onPressed:
                                                                          () {
                                                                        if (GlobalController.to.storeInfo?.phone !=
                                                                            null) {
                                                                          launchUrlString(
                                                                              "tel:${GlobalController.to.storeInfo?.phone}");
                                                                        }
                                                                      },
                                                                      text:
                                                                          "${GlobalController.to.storeInfo?.phone}",
                                                                      icon: LineAwesomeIcons
                                                                          .phone),
                                                                  const SizedBox(
                                                                      height:
                                                                          3),
                                                                  HeroInfoItem(
                                                                      onPressed:
                                                                          () {
                                                                        if (GlobalController.to.storeInfo?.email !=
                                                                            null) {
                                                                          launchUrlString(
                                                                              "mailto:${GlobalController.to.storeInfo?.email}");
                                                                        }
                                                                      },
                                                                      text:
                                                                          "${GlobalController.to.storeInfo?.email}",
                                                                      icon: LineAwesomeIcons
                                                                          .envelope),
                                                                  const SizedBox(
                                                                      height:
                                                                          3),
                                                                  HeroInfoItem(
                                                                      text:
                                                                          "${GlobalController.to.storeInfo?.address}",
                                                                      icon: LineAwesomeIcons
                                                                          .map_marker),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            16.w,
                                                                        width:
                                                                            16.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: AppTheme
                                                                              .to
                                                                              .yellowColor,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.r),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              13.w),
                                                                      Text(
                                                                        "working_hours"
                                                                            .tr,
                                                                        style: AppStyles.heading4.copyWith(
                                                                            color:
                                                                                Colors.white,
                                                                            height: 5.h),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
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
                                                      child: GlobalController
                                                                  .to
                                                                  .storeInfo
                                                                  ?.cover !=
                                                              null
                                                          ? Image.network(
                                                              GlobalController
                                                                  .to
                                                                  .storeInfo!
                                                                  .cover!)
                                                          : Image.asset(
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
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 50.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 180.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "categories".tr,
                                              style: AppStyles.bodyBoldXL
                                                  .copyWith(
                                                      color: Colors.black45),
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
                                                      itemBuilder: (context,
                                                              index) =>
                                                          AppShimmerLoader
                                                              .showShimmerLoader(
                                                            width:
                                                                double.infinity,
                                                            height: 120.h,
                                                            borderRadius: 12,
                                                            bottomMargin: 20.h,
                                                          ))
                                                else
                                                  for (Category category
                                                      in controller.categories)
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          border: controller.selectedCategory !=
                                                                      null &&
                                                                  controller
                                                                          .selectedCategory
                                                                          ?.id ==
                                                                      category
                                                                          .id
                                                              ? Border(
                                                                  left: GlobalController.to.currentLocale.languageCode == "en"
                                                                      ? BorderSide(
                                                                          width: 15
                                                                              .w,
                                                                          color: AppTheme
                                                                              .to
                                                                              .yellowColor)
                                                                      : BorderSide
                                                                          .none,
                                                                  right: GlobalController.to.currentLocale.languageCode == "ar"
                                                                      ? BorderSide(width: 15.w, color: AppTheme.to.yellowColor)
                                                                      : BorderSide.none)
                                                              : null,
                                                          color: AppTheme.to.yellowColor.withOpacity(0.1)),

                                                      margin:
                                                          const EdgeInsets.only(
                                                              bottom: 8),
                                                      // Align to the start (left)

                                                      child: InkWell(
                                                        onTap: () {
                                                          controller
                                                              .onCategorySelected(
                                                                  category);
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.w,
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
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                              Text(
                                                                "${category.productsCount}",
                                                                style: AppStyles
                                                                    .bodyBoldL,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
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
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                          LineAwesomeIcons
                                                              .th_large,
                                                        )
                                                      : const Icon(
                                                          LineAwesomeIcons
                                                              .list),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            productCard(
                                                isGrid: controller.isGrid),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 32.w,
                                      ),
                                      const Expanded(
                                        flex: 1,
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
                              crossAxisCount: 2, childAspectRatio: 1.20),
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
                    "${product.description}".removeHtmlTags(),
                    style: AppStyles.bodyRegularS,
                    maxLines: 2,
                  ),
                ],
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        "${product.currency} ${product.price}",
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                    if (product.hasDiscount != null &&
                        product.hasDiscount!) ...[
                      SizedBox(width: 10.w),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          "${product.originalPrice}",
                          style: AppStyles.bodyMediumM.copyWith(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
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
                            "${product.currency} ${product.price!}",
                            style: AppStyles.bodyBoldL.copyWith(
                              fontWeight: FontWeight.normal,
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
