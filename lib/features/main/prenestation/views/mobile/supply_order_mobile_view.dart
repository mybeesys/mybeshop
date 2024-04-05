import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/domain/entities/supply_order_item.dart';
import 'package:mybeshop/features/main/prenestation/controllers/supply_order_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/empty_widget.dart';

class SupplyOrderMobileView extends StatelessWidget {
  const SupplyOrderMobileView({super.key, required this.supplyOrderNo});

  final String supplyOrderNo;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 841),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetBuilder(
              init: SupplyOrderController(Get.find(), supplyOrderNo),
              builder: (controller) {
                return Title(
                  title: "supply_order".tr,
                  color: Colors.black,
                  child: WillPopScope(
                    onWillPop: () async {
                      GlobalController.to.slug =
                          controller.supplyOrder?.store.slug;
                      Get.offAllNamed(
                        "${AppRoutes.main}/shop/${GlobalController.to.slug}",
                      );
                      return Future(() => true);
                    },
                    child: Scaffold(
                      body: controller.supplyOrderLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.supplyOrder == null
                              ? EmptyProductsWidget(
                                  message: "this_supply_order_not_found".tr,
                                )
                              : SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            if (controller
                                                    .supplyOrder?.store.logo !=
                                                null)
                                              Image.network(
                                                controller
                                                    .supplyOrder!.store.logo!,
                                                width: 50.w,
                                              )
                                            else
                                              Image.asset(
                                                "assets/images/1.png",
                                                width: 50.w,
                                              ),
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  "supply_order".tr,
                                                  style: AppStyles.bodyMediumM,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20.h),
                                        const Divider(),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "${"supply_order_date".tr} : ${controller.supplyOrder?.supplyOrderDetail.date}",
                                          style: AppStyles.bodySemiBoldM,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "${"supply_order_no".tr} : ${controller.supplyOrder?.supplyOrderDetail.no}",
                                          style: AppStyles.bodySemiBoldM,
                                        ),
                                        const Divider(),
                                        Text(
                                          "supplier_information".tr,
                                          style: AppStyles.bodySemiBoldS,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "${"name".tr} : ${controller.supplyOrder?.supplyOrderDetail.supplier.name}",
                                          style: AppStyles.bodySemiBoldS,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "${"phone".tr} : ${controller.supplyOrder?.supplyOrderDetail.supplier.phone}",
                                          style: AppStyles.bodySemiBoldS,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "${"email".tr} : ${controller.supplyOrder?.supplyOrderDetail.supplier.email ?? "null".tr}",
                                          style: AppStyles.bodySemiBoldS,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "${"company".tr} : ${controller.supplyOrder?.supplyOrderDetail.supplier.company ?? "null".tr}",
                                          style: AppStyles.bodySemiBoldS,
                                        ),
                                        SizedBox(height: 20.h),
                                        Text(
                                          "${"address".tr} : ${controller.supplyOrder?.supplyOrderDetail.supplier.address ?? "null".tr}",
                                          style: AppStyles.bodySemiBoldS,
                                        ),
                                        const Divider(),
                                        SizedBox(height: 80.h),
                                        Center(
                                          child: Text(
                                            "items".tr,
                                            style: AppStyles.bodyBoldM,
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                        SupplyOrderItemsTableWidget(
                                          items: controller.supplyOrder!
                                              .supplyOrderDetail.items,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                    ),
                  ),
                );
              });
        });
  }
}

class SupplyOrderItemsTableWidget extends StatelessWidget {
  const SupplyOrderItemsTableWidget({super.key, required this.items});
  final List<SupplyOrderItem> items;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(flex: 0.5),
        border: TableBorder
            .all(), // Allows to add a border decoration around your table
        children: [
          TableRow(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  '#',
                  style: AppStyles.bodyBoldS,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'name'.tr,
                  style: AppStyles.bodyBoldS,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'qty'.tr,
                  style: AppStyles.bodyBoldS,
                ),
              ),
            ],
          ),
          for (SupplyOrderItem item in items)
            TableRow(
                decoration: BoxDecoration(
                    color: items.indexOf(item) % 2 == 0
                        ? Colors.grey.shade300
                        : Colors.grey),
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      "${items.indexOf(item) + 1}",
                      style: AppStyles.bodyRegularS,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      item.name,
                      style: AppStyles.bodyRegularS,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      item.qty.toString(),
                      style: AppStyles.bodyRegularS,
                    ),
                  ),
                ]),
        ],
      ),
    );
  }
}
