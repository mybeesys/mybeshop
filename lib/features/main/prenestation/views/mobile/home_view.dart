import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/prenestation/controllers/main_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/mobile/custom_divider.dart';
import 'package:mybeshop/features/main/prenestation/widgets/navbar_social_media_buttons_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/shared_widgets_and_methods.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(Get.find(), Get.find()),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70.h,
              backgroundColor: AppTheme.to.primaryColor,
              centerTitle: false,
              title: Text(
                "${GlobalController.to.storeInfo?.name}",
                style: AppStyles.bodyBoldL.copyWith(color: Colors.white),
              ),
              actions: [
                NavBarSocialMediaButtonWidget(
                  verticalMargin: 10.h,
                  icon: LineAwesomeIcons.facebook_f,
                  onPressed: () {
                    if (GlobalController.to.storeInfo?.social["facebook"] !=
                        null) {
                      launchUrlString(
                          GlobalController.to.storeInfo!.social["facebook"]!);
                    }
                  },
                ),
                NavBarSocialMediaButtonWidget(
                  verticalMargin: 10.h,
                  icon: LineAwesomeIcons.twitter,
                  onPressed: () {
                    if (GlobalController.to.storeInfo?.social["twitter"] !=
                        null) {
                      launchUrlString(
                          GlobalController.to.storeInfo!.social["twitter"]!);
                    }
                  },
                ),
                NavBarSocialMediaButtonWidget(
                  verticalMargin: 10.h,
                  icon: LineAwesomeIcons.instagram,
                  onPressed: () {
                    if (GlobalController.to.storeInfo?.social["instagram"] !=
                        null) {
                      launchUrlString(
                          GlobalController.to.storeInfo!.social["instagram"]!);
                    }
                  },
                ),
                NavBarSocialMediaButtonWidget(
                  verticalMargin: 10.h,
                  icon: LineAwesomeIcons.snapchat,
                  onPressed: () {
                    if (GlobalController.to.storeInfo?.social["snapchat"] !=
                        null) {
                      launchUrlString(
                          GlobalController.to.storeInfo!.social["snapchat"]!);
                    }
                  },
                ),
                NavBarSocialMediaButtonWidget(
                  verticalMargin: 10.h,
                  icon: LineAwesomeIcons.what_s_app,
                  onPressed: () {
                    if (GlobalController.to.storeInfo?.social["whatsapp"] !=
                        null) {
                      launchUrlString(
                          GlobalController.to.storeInfo!.social["whatsapp"]!);
                    }
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 208.h,
                      decoration: BoxDecoration(
                          color: AppTheme.to.primaryColor,
                          borderRadius: BorderRadius.circular(6.r)),
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      padding: EdgeInsets.all(8.w),
                      child: Row(
                        children: [
                          Container(
                            color: Colors.white,
                            height: double.infinity,
                            width: 150.w,
                            child: GlobalController.to.storeInfo?.logo != null
                                ? Image.network(
                                    GlobalController.to.storeInfo!.logo!)
                                : Image.asset(
                                    "assets/images/bg.png",
                                    height: 750.h,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${GlobalController.to.storeInfo?.heroTitle}",
                                style: AppStyles.bodySemiBoldL
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                "${GlobalController.to.storeInfo?.bio}",
                                style: AppStyles.bodyRegularS
                                    .copyWith(color: Colors.white),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ))
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 150.h,
                      child: controller.categoriesLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: controller.categories.length,
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.only(left: 10.w),
                                child: InkWell(
                                  onTap: () {
                                    controller.onCategorySelected(
                                        controller.categories[index]);
                                  },
                                  child: Column(children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 65.h,
                                          width: 65.h,
                                          decoration: BoxDecoration(
                                              border: controller
                                                          .selectedCategory!
                                                          .id ==
                                                      controller
                                                          .categories[index].id
                                                  ? Border.all(
                                                      width: 2.w,
                                                      color: AppTheme
                                                          .to.primaryColor)
                                                  : null,
                                              color: AppTheme.to.greyColor
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(65.r)),
                                        ),
                                        Positioned(
                                          top: -3.h,
                                          left: 5.w,
                                          right: 5.w,
                                          child: Image.asset(
                                              "assets/images/categories.png"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 70.w,
                                      child: Text(
                                        controller.categories[index].name,
                                        style: AppStyles.bodyMediumS,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                              scrollDirection: Axis.horizontal,
                            ),
                    ),
                    SizedBox(height: 20.h),
                    const CustomDivider(),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "products".tr,
                            style: AppStyles.bodyBoldM,
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(text: "${"filtered_by".tr} :"),
                              TextSpan(
                                  text: controller.selectedCategory != null
                                      ? " ${controller.selectedCategory?.name}"
                                      : " ${"none".tr}"),
                            ]),
                            style: AppStyles.bodyRegularM,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (controller.categoriesLoading.value)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      ListView.builder(
                        itemCount: controller.selectedCategory!.products.length,
                        itemBuilder: (context, index) {
                          Product product =
                              controller.selectedCategory!.products[index];
                          return Container(
                            padding: EdgeInsets.all(8.r),
                            height: 108.h,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.r),
                                      height: 90.h,
                                      width: 90.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius:
                                            BorderRadius.circular(3.r),
                                      ),
                                      child: Image.network(
                                        product.images.isNotEmpty
                                            ? product.images[0]
                                            : "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png",
                                      ),
                                    ),
                                    if (product.hasDiscount != null &&
                                        product.hasDiscount!)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1, horizontal: 3),
                                          decoration: const BoxDecoration(
                                              color: Colors.red),
                                          child: Text(
                                            "${product.discountPercent}%",
                                            style: AppStyles.bodyMediumM
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(width: 11.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.name,
                                        style: AppStyles.bodyBoldM,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${product.price!} ${product.currency}",
                                            style: AppStyles.bodyBoldS.copyWith(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          if (product.hasDiscount ?? false) ...[
                                            Text(
                                              product.originalPrice!,
                                              style: AppStyles.bodyMediumS
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
                                      if (getHasExtrasOrVariantsText(product) !=
                                          null) ...[
                                        SizedBox(height: 10.h),
                                        Text(
                                          getHasExtrasOrVariantsText(product)!,
                                          style: AppStyles.bodyMediumS.copyWith(
                                              color: AppTheme.to.greyColor),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                                addToCartMobileButton(product),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
