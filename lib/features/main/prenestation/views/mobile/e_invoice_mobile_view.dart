import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/features/main/domain/entities/invoice_item.dart';
import 'package:mybeshop/features/main/prenestation/controllers/e_invoice_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/empty_widget.dart';

class EInvoiceMobileView extends StatelessWidget {
  const EInvoiceMobileView({super.key, required this.invoiceNo});

  final String invoiceNo;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder(
            init: EInvoiceController(Get.find(), invoiceNo),
            builder: (controller) {
              return Title(
                title: "taxes_invoice".tr,
                color: Colors.black,
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
                                    horizontal: 20.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        "taxes_invoice".tr,
                                        style: AppStyles.bodyMediumM,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      "${"invoice_date".tr} : ${controller.eInvoice?.invoice.date}",
                                      style: AppStyles.bodySemiBoldM,
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      "${"invoice_no".tr} : ${controller.eInvoice?.invoice.no}",
                                      style: AppStyles.bodySemiBoldM,
                                    ),
                                    SizedBox(height: 20.h),
                                    Center(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Table(
                                          defaultColumnWidth:
                                              IntrinsicColumnWidth(),
                                          border: TableBorder
                                              .all(), // Allows to add a border decoration around your table
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(5.0.r),
                                                child: Text(
                                                  '#',
                                                  style: AppStyles.bodyBoldS,
                                                ),
                                              ),
                                              Center(
                                                  child: Padding(
                                                padding: EdgeInsets.all(5.0.r),
                                                child: Text(
                                                  'product'.tr,
                                                  style: AppStyles.bodyBoldS,
                                                ),
                                              )),
                                              Center(
                                                  child: Padding(
                                                padding: EdgeInsets.all(5.0.r),
                                                child: Text(
                                                  'qty'.tr,
                                                  style: AppStyles.bodyBoldS,
                                                ),
                                              )),
                                              Center(
                                                  child: Padding(
                                                padding: EdgeInsets.all(5.0.r),
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Text(
                                                    'price'.tr,
                                                    style: AppStyles.bodyBoldS,
                                                  ),
                                                ),
                                              )),
                                              Center(
                                                  child: Padding(
                                                padding: EdgeInsets.all(5.0.r),
                                                child: Text(
                                                  'discount'.tr,
                                                  style: AppStyles.bodyBoldS,
                                                ),
                                              )),
                                              Center(
                                                  child: Padding(
                                                padding: EdgeInsets.all(5.0.r),
                                                child: Text(
                                                  'tax'.tr,
                                                  style: AppStyles.bodyBoldS,
                                                ),
                                              )),
                                              Center(
                                                  child: Padding(
                                                padding: EdgeInsets.all(5.0.w),
                                                child: Text(
                                                  'sub_total'.tr,
                                                  style: AppStyles.bodyMediumM,
                                                ),
                                              )),
                                            ]),
                                            for (InvoiceItem item in controller
                                                .eInvoice!.invoice.items) ...[
                                              TableRow(
                                                  decoration: BoxDecoration(
                                                      color: controller
                                                                      .eInvoice!
                                                                      .invoice
                                                                      .items
                                                                      .indexOf(
                                                                          item) %
                                                                  2 ==
                                                              0
                                                          ? Colors.grey.shade300
                                                          : Colors.grey),
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(5.0.r),
                                                      child: Text(
                                                        "${controller.eInvoice!.invoice.items.indexOf(item) + 1}",
                                                        style: AppStyles
                                                            .bodyRegularS,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(5.0.r),
                                                      child: Text(
                                                        item.name,
                                                        style: AppStyles
                                                            .bodyRegularS,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(5.0.r),
                                                      child: Text(
                                                        item.qty.toString(),
                                                        style: AppStyles
                                                            .bodyRegularS,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(5.0.r),
                                                      child: Text(
                                                        item.price,
                                                        style: AppStyles
                                                            .bodyRegularS,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(5.0.r),
                                                      child: Text(
                                                        item.discount,
                                                        style: AppStyles
                                                            .bodyRegularS,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(5.0.r),
                                                      child: Text(
                                                        item.tax,
                                                        style: AppStyles
                                                            .bodyRegularS,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(5.0.r),
                                                      child: Text(
                                                        item.subTotal,
                                                        style: AppStyles
                                                            .bodyRegularM,
                                                      ),
                                                    ),
                                                  ]),
                                            ]
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30.h),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 50.w,
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              controller
                                                  .eInvoice!.invoice.total,
                                              style: AppStyles.bodyRegularS,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "total".tr,
                                          style: AppStyles.bodyRegularS,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 50.w,
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              controller
                                                  .eInvoice!.invoice.discount,
                                              style: AppStyles.bodyRegularS,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text("discount".tr,
                                            style: AppStyles.bodyRegularS),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 50.w,
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              controller.eInvoice!.invoice
                                                  .totalAfterDiscount,
                                              style: AppStyles.bodyRegularS,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text("total_after_discount".tr,
                                            style: AppStyles.bodyRegularS),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 50.w,
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              controller.eInvoice!.invoice.tax,
                                              style: AppStyles.bodyRegularS,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text("added_tax".tr,
                                            style: AppStyles.bodyRegularS),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 50.w,
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: Text(
                                              controller.eInvoice!.invoice
                                                  .totalAfterTaxes,
                                              style: AppStyles.bodyRegularS,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text("total_after_taxes".tr,
                                            style: AppStyles.bodyRegularS),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              controller.eInvoice!.invoice
                                                  .totalWrittenAr,
                                              style: AppStyles.bodyRegularS,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 60.h),
                                    Row(
                                      children: [
                                        Image.network(
                                            "https://api.qrserver.com/v1/create-qr-code/?size=60x60&data=${controller.eInvoice?.invoice.no}"),
                                        SizedBox(width: 30.w),
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
                                                    style:
                                                        AppStyles.bodyMediumS),
                                                SizedBox(height: 20.h),
                                                Text(
                                                  controller.eInvoice!
                                                      .termsAndConditions,
                                                  style: AppStyles.bodyRegularS,
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
              );
            });
      },
    );
  }
}
