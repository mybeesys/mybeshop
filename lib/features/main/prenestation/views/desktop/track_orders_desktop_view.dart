import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/domain/entities/order.dart';
import 'package:mybeshop/features/main/domain/entities/order_detail.dart';
import 'package:mybeshop/features/main/prenestation/controllers/track_orders_contorller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/empty_widget.dart';

class TrackOrdersDesktopView extends StatelessWidget {
  const TrackOrdersDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackOrdersController>(
        init: TrackOrdersController(Get.find()),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: AppTheme.to.primaryColor,
              foregroundColor: Colors.white,
              centerTitle: false,
              title: Text(
                "track_orders".tr,
                style: AppStyles.bodyBoldL,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight * 1.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      child: Text(
                        "pleae_enter_phone_number_to_get_orders".tr,
                        style: AppStyles.bodyRegularS
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CupertinoSearchTextField(
                          itemColor: Colors.grey.shade50,
                          controller: controller.searchInput,
                          onSubmitted: (v) => controller.onSearch(v),
                          placeholder: "phone".tr,
                          style: AppStyles.bodyMediumXL.copyWith(
                              fontFamily: "Alexandria", color: Colors.white),
                        )),
                    SizedBox(height: 50.h),
                    TabBar(
                      controller: controller.tabController,
                      tabs: [
                        for (var filter in controller.filters)
                          Tab(
                            text: filter.tr,
                          ),
                      ],
                    ),
                  ],
                ), //based on searchBar height
              ),
            ),
            body: controller.ordersLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TabBarView(
                    controller: controller.tabController,
                    children: [
                      for (var filter in controller.filters)
                        OrdersListWidget(
                            orders: filter == "all"
                                ? controller.orders
                                : controller.orders
                                    .where(
                                        (element) => element.status == filter)
                                    .toList()),
                    ],
                  ),
          );
        });
  }
}

class OrdersListWidget extends StatelessWidget {
  const OrdersListWidget({
    required this.orders,
    super.key,
  });
  final List<Order> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return EmptyProductsWidget(
        message: "no_orders_to_show".tr,
      );
    } else {
      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 35.h),
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
          margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            children: [
              Container(
                height: 250.w,
                width: 250.w,
                decoration: BoxDecoration(color: Colors.grey.shade50),
                child: Image.asset("assets/images/bg.png"),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "order_no".tr,
                          style: AppStyles.bodyMediumXL
                              .copyWith(color: Colors.blue),
                        ),
                        Text(
                          "#${orders[index].no}",
                          style: AppStyles.bodyBoldXL
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "order_status".tr,
                          style: AppStyles.bodyMediumXL
                              .copyWith(color: Colors.blue),
                        ),
                        Text(
                          orders[index].status.tr,
                          style: AppStyles.bodyBoldXL
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.w),
                    Row(
                      children: [
                        Icon(
                          LineAwesomeIcons.user,
                          size: 35.sp,
                          color: AppTheme.to.greyColor,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          orders[index].customer.name,
                          style: AppStyles.bodyRegularL
                              .copyWith(color: AppTheme.to.greyColor),
                        ),
                      ],
                    ),
                    const Divider(),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "tax".tr,
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          orders[index].tax,
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "delivery".tr,
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          orders[index].delivery,
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "discount".tr,
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          orders[index].discount,
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const Divider(),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "total".tr,
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          orders[index].total,
                          style: AppStyles.bodyMediumL
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.w),
              SizedBox(
                height: 250.w,
                child: const VerticalDivider(
                  width: 3,
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                children: [
                  SizedBox(
                    width: 350.w,
                    height: 200.h,
                    child: OutlinedButton(
                        style: ButtonStyle(
                          elevation:
                              const MaterialStatePropertyAll<double>(0.0),
                          foregroundColor: MaterialStatePropertyAll<Color>(
                              AppTheme.to.primaryColor),
                        ),
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            titlePadding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "order_details".tr,
                                  style: AppStyles.bodyMediumM,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                            backgroundColor: Colors.grey.shade100,
                            content: SingleChildScrollView(
                              child: SizedBox(
                                // decoration: BoxDecoration(),
                                width: 500.w,
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: orders[index].details.length,
                                      itemBuilder: (context, idx) {
                                        OrderDetail detail =
                                            orders[index].details[idx];
                                        return Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          padding: EdgeInsets.all(10.w),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.w),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 80.w,
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.grey.shade300),
                                              ),
                                              SizedBox(width: 10.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(detail.name,
                                                        style: AppStyles
                                                            .bodyBoldL),
                                                    SizedBox(height: 10.h),
                                                    Text(
                                                      "${"qty".tr}: ${detail.qty}",
                                                      style:
                                                          AppStyles.bodyMediumM,
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      child: Text(
                                                        detail.price,
                                                        style: AppStyles
                                                            .bodyMediumM,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 10.w),
                                              Text(
                                                "${"cancelled".tr}: ${detail.cancelled}",
                                                style: AppStyles.bodyRegularM
                                                    .copyWith(
                                                        color: Colors.red),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                        },
                        child: Text(
                          "show_details".tr,
                          style: AppStyles.bodyMediumXL,
                        )),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 350.w,
                    height: 200.h,
                    child: OutlinedButton(
                        style: ButtonStyle(
                          elevation:
                              const MaterialStatePropertyAll<double>(0.0),
                          foregroundColor: MaterialStatePropertyAll<Color>(
                              AppTheme.to.primaryColor),
                        ),
                        onPressed: () {
                          GlobalController.to.slug = orders[index].no;
                          Get.offAllNamed(
                              "${AppRoutes.einvoice}/${GlobalController.to.slug}");
                        },
                        child: Text(
                          "open_e_invoice".tr,
                          style: AppStyles.bodyMediumXL,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
        itemCount: orders.length,
      );
    }
  }
}
