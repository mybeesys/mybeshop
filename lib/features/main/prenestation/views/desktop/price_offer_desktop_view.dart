import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer_additional_cost.dart';
import 'package:mybeshop/features/main/domain/entities/price_offer_product.dart';
import 'package:mybeshop/features/main/domain/entities/price_offet_service.dart';
// import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/prenestation/controllers/price_offer_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/empty_widget.dart';

import '../../../../global/presentation/global_controller.dart';

class PriceOfferDesktopView extends StatelessWidget {
  const PriceOfferDesktopView({super.key, required this.priceOfferNo});
  final String priceOfferNo;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PriceOfferController(Get.find(), priceOfferNo),
      builder: (controller) {
        return Title(
          title: "price_offer".tr,
          color: Colors.black,
          child: WillPopScope(
            onWillPop: () async {
              GlobalController.to.slug = controller.priceOffer?.store.slug;
              Get.offAllNamed(
                "${AppRoutes.main}/shop/${GlobalController.to.slug}",
              );
              return Future(() => true);
            },
            child: Scaffold(
              body: controller.priceOfferLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.priceOffer == null
                      ? EmptyProductsWidget(
                          message: "this_offer_not_found".tr,
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 200.w, vertical: 100.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    if (controller.priceOffer?.store.logo !=
                                        null)
                                      Image.network(
                                        controller.priceOffer!.store.logo!,
                                        width: 100.w,
                                      )
                                    else
                                      Image.asset(
                                        "assets/images/1.png",
                                        width: 100.w,
                                      ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "price_offer".tr,
                                          style: AppStyles.bodyMediumXL
                                              .copyWith(fontSize: 25.sp),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 35.h),
                                const Divider(),
                                SizedBox(height: 35.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${"price_offer_date".tr} : ${controller.priceOffer?.priceOfferDetail.date}",
                                          style: AppStyles.bodySemiBoldXL,
                                        ),
                                        SizedBox(height: 30.h),
                                        Text(
                                          "${"price_offer_no".tr} : ${controller.priceOffer?.priceOfferDetail.no}",
                                          style: AppStyles.bodySemiBoldXL,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "client_information".tr,
                                          style: AppStyles.bodySemiBoldXL,
                                        ),
                                        SizedBox(height: 30.h),
                                        Text(
                                          "${"name".tr} : ${controller.priceOffer?.priceOfferDetail.customer.name}",
                                          style: AppStyles.bodySemiBoldXL,
                                        ),
                                        SizedBox(height: 30.h),
                                        Text(
                                          "${"phone".tr} : ${controller.priceOffer?.priceOfferDetail.customer.phone}",
                                          style: AppStyles.bodySemiBoldXL,
                                        ),
                                        SizedBox(height: 30.h),
                                        Text(
                                          "${"address".tr} : ${controller.priceOffer?.priceOfferDetail.customer.deliveryAddress ?? "null".tr}",
                                          style: AppStyles.bodySemiBoldXL,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                if (controller.priceOffer!.priceOfferDetail
                                    .products.isNotEmpty) ...[
                                  SizedBox(height: 80.h),
                                  Center(
                                    child: Text(
                                      "products".tr,
                                      style: AppStyles.bodyBoldXL,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  ProductsTableWiget(
                                    products: controller
                                        .priceOffer!.priceOfferDetail.products,
                                  ),
                                ],
                                if (controller.priceOffer!.priceOfferDetail
                                    .services.isNotEmpty) ...[
                                  SizedBox(height: 80.h),
                                  Center(
                                    child: Text(
                                      "services".tr,
                                      style: AppStyles.bodyBoldXL,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  ServicesTableWiget(
                                    services: controller
                                        .priceOffer!.priceOfferDetail.services,
                                  ),
                                ],
                                if (controller.priceOffer!.priceOfferDetail
                                    .additionalCosts.isNotEmpty) ...[
                                  SizedBox(height: 80.h),
                                  Center(
                                    child: Text(
                                      "additional_costs".tr,
                                      style: AppStyles.bodyBoldXL,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  AdditionalCostsTableWiget(
                                    additionalCosts: controller.priceOffer!
                                        .priceOfferDetail.additionalCosts,
                                  ),
                                ],
                                SizedBox(height: 60.h),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70.w,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          controller.priceOffer!
                                              .priceOfferDetail.total,
                                          style: AppStyles.bodyRegularL,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "total".tr,
                                      style: AppStyles.bodyRegularL,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70.w,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          controller.priceOffer!
                                              .priceOfferDetail.discount,
                                          style: AppStyles.bodyRegularL,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "discount".tr,
                                      style: AppStyles.bodyRegularL,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70.w,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          controller
                                              .priceOffer!
                                              .priceOfferDetail
                                              .totalAfterDiscount,
                                          style: AppStyles.bodyRegularL,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "total_after_discount".tr,
                                      style: AppStyles.bodyRegularL,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70.w,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          controller
                                              .priceOffer!.priceOfferDetail.tax,
                                          style: AppStyles.bodyRegularL,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "tax".tr,
                                      style: AppStyles.bodyRegularL,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 70.w,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Text(
                                          controller.priceOffer!
                                              .priceOfferDetail.totalWithTax,
                                          style: AppStyles.bodyRegularL,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      "total_after_taxes".tr,
                                      style: AppStyles.bodyRegularL,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
            ),
          ),
        );
      },
    );
  }
}

class ProductsTableWiget extends StatelessWidget {
  const ProductsTableWiget({super.key, required this.products});
  final List<PriceOfferProduct> products;
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
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'name'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'unit_price'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'qty'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'discount'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'tax'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'extras'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'sub_total'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
            ],
          ),
          for (PriceOfferProduct product in products)
            TableRow(
                decoration: BoxDecoration(
                    color: products.indexOf(product) % 2 == 0
                        ? Colors.grey.shade300
                        : Colors.grey),
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      "${products.indexOf(product) + 1}",
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      product.name,
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        product.unitPrice,
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      product.qty.toString(),
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        product.discount,
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        product.tax,
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      product.extras.length.toString(),
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        product.subTotal,
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                  ),
                ]),
        ],
      ),
    );
  }
}

class ServicesTableWiget extends StatelessWidget {
  const ServicesTableWiget({super.key, required this.services});
  final List<PriceOfferService> services;
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
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'name'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'description'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'price'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'tax'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'sub_total'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
            ],
          ),
          for (PriceOfferService service in services)
            TableRow(
                decoration: BoxDecoration(
                    color: services.indexOf(service) % 2 == 0
                        ? Colors.grey.shade300
                        : Colors.grey),
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      "${services.indexOf(service) + 1}",
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      service.name,
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      service.description,
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        service.price,
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        service.tax,
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        service.subTotal,
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                  ),
                ]),
        ],
      ),
    );
  }
}

class AdditionalCostsTableWiget extends StatelessWidget {
  const AdditionalCostsTableWiget({super.key, required this.additionalCosts});
  final List<PriceOfferAdditionalCost> additionalCosts;
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
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'name'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'description'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.0.w),
                child: Text(
                  'cost'.tr,
                  style: AppStyles.bodyBoldL,
                ),
              ),
            ],
          ),
          for (PriceOfferAdditionalCost cost in additionalCosts)
            TableRow(
                decoration: BoxDecoration(
                    color: additionalCosts.indexOf(cost) % 2 == 0
                        ? Colors.grey.shade300
                        : Colors.grey),
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      "${additionalCosts.indexOf(cost) + 1}",
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      cost.name,
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Text(
                      cost.description,
                      style: AppStyles.bodyBoldL,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5.0.w),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        cost.cost,
                        style: AppStyles.bodyBoldL,
                      ),
                    ),
                  ),
                ]),
        ],
      ),
    );
  }
}
