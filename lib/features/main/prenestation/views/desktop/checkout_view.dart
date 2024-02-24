import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/prenestation/controllers/checkout_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_select_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_text_form_field_widget.dart';
import 'package:intl/intl.dart' as intl;

class CheckoutView extends GetView {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckoutController>(
          init: CheckoutController(
              Get.find(), Get.find(), Get.find(), Get.find()),
          builder: (controller) {
            return SafeArea(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TabBar(
                        labelColor: AppTheme.to.primaryColor,
                        controller: controller.tabController,
                        tabs: [
                          Tab(
                            icon: Icon(LineAwesomeIcons.user),
                            text: "personal_information".tr,
                          ),
                          Tab(
                            icon: Icon(LineAwesomeIcons.credit_card),
                            text: "payment_methods".tr,
                          ),
                          Tab(
                            icon: Icon(LineAwesomeIcons.truck_moving),
                            text: "track_order".tr,
                          ),
                        ],
                        onTap: (index) => controller.onStepClicked(index),
                      ),
                      SizedBox(width: 140.h),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 40.h),
                          child: TabBarView(
                              controller: controller.tabController,
                              children: controller.steps),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 40.h),
                        child: Row(
                          children: [
                            if (controller.tabController.index < 2)
                              MaterialButton(
                                height: 140.h,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: AppTheme.to.primaryColor,
                                onPressed: () {
                                  controller.onStepChanged(true);
                                },
                                child: Text(
                                  "next".tr,
                                  style: AppStyles.bodyMediumL
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            if (controller.tabController.index > 0) ...[
                              SizedBox(width: 20.w),
                              MaterialButton(
                                height: 140.h,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: AppTheme.to.primaryColor,
                                onPressed: () {
                                  controller.onStepChanged(false);
                                },
                                child: Text(
                                  "previus".tr,
                                  style: AppStyles.bodyMediumL
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ]
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade50,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30.h, horizontal: 20.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "order_summery".tr,
                                        style: AppStyles.bodyBoldXL,
                                      ),
                                      Text(
                                        intl.DateFormat("EEE, M/d/y")
                                            .format(DateTime.now()),
                                        style: AppStyles.bodyBoldXL,
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  itemBuilder: (context, index) {
                                    var item =
                                        controller.shoppingCart?.items[index];
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15.h),
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 70.w,
                                            width: 70.w,
                                            padding: EdgeInsets.all(3.w),
                                            decoration: BoxDecoration(
                                                color: AppTheme.to.greyColor
                                                    .withOpacity(0.4)),
                                            child: Image.network(item?.image ??
                                                "https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png"),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                              child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 15.h),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${item?.name}",
                                                        style:
                                                            AppStyles.bodyBoldL,
                                                      ),
                                                      SizedBox(
                                                        height: 15.h,
                                                      ),
                                                      Text.rich(
                                                        TextSpan(children: [
                                                          TextSpan(
                                                              text:
                                                                  "${"type".tr}: "),
                                                          TextSpan(
                                                            text:
                                                                "${item?.type}",
                                                          ),
                                                        ]),
                                                        style: AppStyles
                                                            .bodyMediumL
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${item?.priceFormatted}",
                                                      style:
                                                          AppStyles.bodyBoldL,
                                                    ),
                                                    SizedBox(
                                                      height: 15.h,
                                                    ),
                                                    Text.rich(
                                                      TextSpan(children: [
                                                        TextSpan(
                                                            text:
                                                                "${"qty".tr}: "),
                                                        TextSpan(
                                                          text: "${item?.qty}",
                                                        ),
                                                      ]),
                                                      style: AppStyles
                                                          .bodyMediumL
                                                          .copyWith(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.shoppingCart?.items.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                                // for (var item in controller.shoppingCart!.items)
                                //   Text(item.name),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 80.h, horizontal: 20.h),
                          child: Column(
                            children: [
                              OrderSummeryItemWidget(
                                name: "sub_total",
                                value:
                                    "${controller.shoppingCart?.subTotalFotmatted}",
                              ),
                              SizedBox(height: 10.h),
                              Divider(),
                              SizedBox(
                                height: 10.h,
                              ),
                              OrderSummeryItemWidget(
                                name: "tax",
                                value:
                                    "${controller.shoppingCart?.taxFormatted}",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ));
          }),
    );
  }
}

class OrderSummeryItemWidget extends StatelessWidget {
  const OrderSummeryItemWidget({
    required this.name,
    required this.value,
    super.key,
  });
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name.tr,
          style: AppStyles.bodyBoldL,
        ),
        Text(
          value,
          style: AppStyles.bodyMediumL.copyWith(color: Colors.grey),
        )
      ],
    );
  }
}

class PaymentMethodsStepWidget extends StatelessWidget {
  const PaymentMethodsStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
        init: Get.find<CheckoutController>(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 300.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PaymentMethodTypeWidget(
                        isSelected:
                            controller.paymentMethod == "cash_on_delivery",
                        onPressed: () {
                          controller.onPaymentMethodChanged("cash_on_delivery");
                        },
                        icon: "assets/images/cod.png",
                        name: "cash_on_delivery".tr,
                      ),
                      // PaymentMethodTypeWidget(
                      //   isSelected: controller.paymentMethod == "credit_card",
                      //   onPressed: () {
                      //     controller.onPaymentMethodChanged("credit_card");
                      //   },
                      //   icon: "assets/images/credit.png",
                      //   name: "credit_card".tr,
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class PaymentMethodTypeWidget extends StatelessWidget {
  const PaymentMethodTypeWidget({
    super.key,
    required this.name,
    required this.icon,
    this.isSelected = false,
    this.onPressed,
  });
  final String name;
  final String icon;
  final bool isSelected;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: 190.w,
        width: 190.w,
        decoration: BoxDecoration(
            color: isSelected ? AppTheme.to.primaryColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              SizedBox(
                height: 110.w,
                width: 110.w,
                child: Image.asset(icon),
              ),
              SizedBox(height: 10.h),
              Text(
                name,
                style: AppStyles.bodyBoldL.copyWith(
                    color:
                        isSelected ? Colors.white : AppTheme.to.primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TrackOrderStepWidget extends StatelessWidget {
  const TrackOrderStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [],
      ),
    );
  }
}

class PersonalInformationStepWidget extends StatelessWidget {
  const PersonalInformationStepWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<CheckoutController>(),
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormFieldWidget(
                            label: "first_name".tr,
                            icon: LineAwesomeIcons.user,
                          ),
                        ),
                        SizedBox(width: 40.w),
                        Expanded(
                          child: CustomTextFormFieldWidget(
                            label: "phone".tr,
                            icon: LineAwesomeIcons.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Text(
                      "address_info".tr,
                      style: AppStyles.heading4
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckoutController.to.stateLoading.value
                              ? const LinearProgressIndicator()
                              : CustomSelectWidget(
                                  horizontalMargin: 0,
                                  enabled:
                                      CheckoutController.to.states.isNotEmpty,
                                  textStyle: AppStyles.bodyBoldXL,
                                  leadingIcon: const Icon(LineAwesomeIcons.map),
                                  name: "state".tr,
                                  items: CheckoutController.to.states
                                      .map((e) => DropdownMenuEntry(
                                          value: e, label: e.name))
                                      .toList(),
                                  onSelected: (v) =>
                                      CheckoutController.to.onStateSelected(v),
                                ),
                        ),
                        SizedBox(width: 40.w),
                        Expanded(
                          child: CheckoutController.to.citiesLoading.value
                              ? const LinearProgressIndicator()
                              : CustomSelectWidget(
                                  horizontalMargin: 0,
                                  enabled:
                                      CheckoutController.to.cities.isNotEmpty,
                                  textStyle: AppStyles.bodyBoldXL,
                                  leadingIcon:
                                      const Icon(LineAwesomeIcons.map_signs),
                                  name: "city".tr,
                                  items: CheckoutController.to.cities
                                      .map((e) => DropdownMenuEntry(
                                          value: e, label: e.name))
                                      .toList(),
                                  onSelected: (v) =>
                                      CheckoutController.to.onCitySelected(v),
                                ),
                        ),
                        SizedBox(width: 40.w),
                        Expanded(
                          child: CheckoutController.to.areasLoading.value
                              ? const LinearProgressIndicator()
                              : CustomSelectWidget(
                                  horizontalMargin: 0,
                                  enabled:
                                      CheckoutController.to.areas.isNotEmpty,
                                  textStyle: AppStyles.bodyBoldXL,
                                  leadingIcon:
                                      const Icon(LineAwesomeIcons.map_marker),
                                  name: "area".tr,
                                  items: CheckoutController.to.areas
                                      .map((e) => DropdownMenuEntry(
                                          value: e, label: e.name))
                                      .toList(),
                                  onSelected: (v) =>
                                      CheckoutController.to.onAreaSelected(v),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormFieldWidget(
                            maxLines: 4,
                            label: "delivery_address".tr,
                            icon: LineAwesomeIcons.map_marked,
                          ),
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
          );
        });
  }
}
