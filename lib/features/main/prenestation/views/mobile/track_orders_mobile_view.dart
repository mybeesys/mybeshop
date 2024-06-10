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

class TrackOrdersMobileView extends StatelessWidget {
  const TrackOrdersMobileView({super.key});

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
                style: AppStyles.bodyMediumM,
              ),
              bottom: GlobalController.to.storeInfo?.ordersTrackingEnabled ==
                      false
                  ? null
                  : PreferredSize(
                      preferredSize:
                          const Size.fromHeight(kToolbarHeight * 2.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: Text(
                              "pleae_enter_phone_number_to_get_orders".tr,
                              style: AppStyles.bodyRegularS
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: CupertinoSearchTextField(
                                itemColor: Colors.grey.shade50,
                                controller: controller.searchInput,
                                onSubmitted: (v) => controller.onSearch(v),
                                placeholder:
                                    "${"phone".tr} - EXP: 966557013119",
                                style: AppStyles.bodyMediumM.copyWith(
                                    fontFamily: "Alexandria",
                                    color: Colors.white),
                              )),
                          SizedBox(height: 20.h),
                          TabBar(
                            isScrollable: true,
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
                : GlobalController.to.storeInfo?.ordersTrackingEnabled == false
                    ? Center(
                        child: Text(
                          "this_store_have_no_traking_service".tr,
                          style: AppStyles.bodyBoldL,
                        ),
                      )
                    : TabBarView(
                        controller: controller.tabController,
                        children: [
                          for (var filter in controller.filters)
                            OrdersListWidget(
                                orders: filter == "all"
                                    ? controller.orders
                                    : controller.orders
                                        .where((element) =>
                                            element.status == filter)
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
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "order_no".tr,
                              style: AppStyles.bodyMediumL
                                  .copyWith(color: Colors.blue),
                            ),
                            Text(
                              "#${orders[index].no}",
                              style: AppStyles.bodyBoldL
                                  .copyWith(color: Colors.black),
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
                              "order_status".tr,
                              style: AppStyles.bodyRegularS
                                  .copyWith(color: Colors.blue),
                            ),
                            Text(
                              orders[index].status.tr,
                              style: AppStyles.bodyMediumM
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
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
                              style: AppStyles.bodyRegularM
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
                              style: AppStyles.bodyMediumM
                                  .copyWith(color: Colors.grey),
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                orders[index].tax,
                                style: AppStyles.bodyMediumM
                                    .copyWith(color: Colors.grey),
                              ),
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
                              style: AppStyles.bodyMediumM
                                  .copyWith(color: Colors.grey),
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                orders[index].delivery,
                                style: AppStyles.bodyMediumM
                                    .copyWith(color: Colors.grey),
                              ),
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
                              style: AppStyles.bodyMediumM
                                  .copyWith(color: Colors.grey),
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                orders[index].discount,
                                style: AppStyles.bodyMediumM
                                    .copyWith(color: Colors.grey),
                              ),
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
                              style: AppStyles.bodyMediumM
                                  .copyWith(color: Colors.grey),
                            ),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                orders[index].total,
                                style: AppStyles.bodyMediumM
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              const Divider(),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: OutlinedButton(
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll<double>(0.0),
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: orders[index].details.length,
                                  itemBuilder: (context, idx) {
                                    OrderDetail detail =
                                        orders[index].details[idx];
                                    return Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      padding: EdgeInsets.all(10.w),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.w),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 50.w,
                                            width: 50.w,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(detail.name,
                                                    style:
                                                        AppStyles.bodyMediumM),
                                                SizedBox(height: 5.h),
                                                Text(
                                                  "${"qty".tr}: ${detail.qty}",
                                                  style: AppStyles.bodyMediumS,
                                                ),
                                                SizedBox(height: 5.h),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Text(
                                                    detail.price,
                                                    style:
                                                        AppStyles.bodyMediumS,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            "${"cancelled".tr}: ${detail.cancelled}",
                                            style: AppStyles.bodyRegularS
                                                .copyWith(color: Colors.red),
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
                    )),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: OutlinedButton(
                    style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll<double>(0.0),
                      foregroundColor: MaterialStatePropertyAll<Color>(
                          AppTheme.to.primaryColor),
                    ),
                    onPressed: () {
                      GlobalController.to.slug = orders[index].no;
                      Get.offAllNamed(
                          "${AppRoutes.einvoice}/${orders[index].no}");
                    },
                    child: Text(
                      "open_e_invoice".tr,
                    )),
              ),
            ],
          ),
        ),
        itemCount: orders.length,
      );
    }
  }
}
