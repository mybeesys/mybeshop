import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/features/main/domain/entities/invoice_item.dart';
import 'package:mybeshop/features/main/prenestation/controllers/e_invoice_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/empty_widget.dart';

class EInvoiceDesktopView extends StatelessWidget {
  const EInvoiceDesktopView({super.key, required this.invoiceNo});
  final String invoiceNo;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: EInvoiceController(Get.find(), invoiceNo),
        builder: (controller) {
          return Title(
            title: "taxes_invoice".tr,
            color: Colors.black,
            child: WillPopScope(
              onWillPop: () async => await Future.value(false),
              child: Scaffold(
                body: controller.eInvoiceLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.eInvoice == null
                        ? EmptyProductsWidget(
                            message: "this_invoice_not_found".tr,
                          )
                        : SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 200.w, vertical: 100.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "taxes_invoice".tr,
                                      style: AppStyles.bodyMediumXL
                                          .copyWith(fontSize: 25.sp),
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  Text(
                                    "${"invoice_date".tr} : ${controller.eInvoice?.invoice.date}",
                                    style: AppStyles.bodySemiBoldXL,
                                  ),
                                  SizedBox(height: 30.h),
                                  Text(
                                    "${"invoice_no".tr} : ${controller.eInvoice?.invoice.no}",
                                    style: AppStyles.bodySemiBoldXL,
                                  ),
                                  SizedBox(height: 40.h),
                                  Center(
                                    child: Table(
                                      defaultColumnWidth:
                                          const IntrinsicColumnWidth(flex: 0.5),
                                      border: TableBorder
                                          .all(), // Allows to add a border decoration around your table
                                      children: [
                                        TableRow(children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Text(
                                              '#',
                                              style: AppStyles.bodyBoldL,
                                            ),
                                          ),
                                          Center(
                                              child: Padding(
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Text(
                                              'product'.tr,
                                              style: AppStyles.bodyBoldL,
                                            ),
                                          )),
                                          Center(
                                              child: Padding(
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Text(
                                              'qty'.tr,
                                              style: AppStyles.bodyBoldL,
                                            ),
                                          )),
                                          Center(
                                              child: Padding(
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: Text(
                                                'price'.tr,
                                                style: AppStyles.bodyBoldL,
                                              ),
                                            ),
                                          )),
                                          Center(
                                              child: Padding(
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Text(
                                              'discount'.tr,
                                              style: AppStyles.bodyBoldL,
                                            ),
                                          )),
                                          Center(
                                              child: Padding(
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Text(
                                              'tax'.tr,
                                              style: AppStyles.bodyBoldL,
                                            ),
                                          )),
                                          Center(
                                              child: Padding(
                                            padding: EdgeInsets.all(5.0.w),
                                            child: Text(
                                              'sub_total'.tr,
                                              style: AppStyles.bodyBoldL,
                                            ),
                                          )),
                                        ]),
                                        for (InvoiceItem item in controller
                                            .eInvoice!.invoice.items) ...[
                                          TableRow(
                                              decoration: BoxDecoration(
                                                  color: controller.eInvoice!
                                                                  .invoice.items
                                                                  .indexOf(
                                                                      item) %
                                                              2 ==
                                                          0
                                                      ? Colors.grey.shade300
                                                      : Colors.grey),
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      EdgeInsets.all(5.0.w),
                                                  child: Text(
                                                    "${controller.eInvoice!.invoice.items.indexOf(item) + 1}",
                                                    style: AppStyles.bodyBoldL,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      EdgeInsets.all(5.0.w),
                                                  child: Text(
                                                    item.name,
                                                    style: AppStyles.bodyBoldL,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      EdgeInsets.all(5.0.w),
                                                  child: Text(
                                                    item.qty.toString(),
                                                    style: AppStyles.bodyBoldL,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      EdgeInsets.all(5.0.w),
                                                  child: Text(
                                                    item.price,
                                                    style: AppStyles.bodyBoldL,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      EdgeInsets.all(5.0.w),
                                                  child: Text(
                                                    item.discount,
                                                    style: AppStyles.bodyBoldL,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      EdgeInsets.all(5.0.w),
                                                  child: Text(
                                                    item.tax,
                                                    style: AppStyles.bodyBoldL,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      EdgeInsets.all(5.0.w),
                                                  child: Text(
                                                    item.subTotal,
                                                    style: AppStyles.bodyBoldL,
                                                  ),
                                                ),
                                              ]),
                                        ]
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 60.h),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 70.w,
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text(
                                            controller.eInvoice!.invoice.total,
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
                                            controller
                                                .eInvoice!.invoice.discount,
                                            style: AppStyles.bodyRegularL,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text("discount".tr,
                                          style: AppStyles.bodyRegularL),
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
                                            controller.eInvoice!.invoice
                                                .totalAfterDiscount,
                                            style: AppStyles.bodyRegularL,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text("total_after_discount".tr,
                                          style: AppStyles.bodyRegularL),
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
                                            controller.eInvoice!.invoice.tax,
                                            style: AppStyles.bodyRegularL,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text("added_tax".tr,
                                          style: AppStyles.bodyRegularL),
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
                                            controller.eInvoice!.invoice
                                                .totalAfterTaxes,
                                            style: AppStyles.bodyRegularL,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text("total_after_taxes".tr,
                                          style: AppStyles.bodyRegularL),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            controller.eInvoice!.invoice
                                                .totalWrittenAr,
                                            style: AppStyles.bodyRegularL,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 80.h),
                                  Row(
                                    children: [
                                      Image.network(
                                          "https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=${controller.eInvoice?.invoice.no}"),
                                      SizedBox(width: 50.w),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("terms_and_conditions".tr,
                                                  style: AppStyles.bodyMediumL),
                                              SizedBox(height: 20.h),
                                              Text(
                                                controller.eInvoice!
                                                    .termsAndConditions,
                                                style: AppStyles.bodyRegularM,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
              ),
            ),
          );
        });
  }
}
