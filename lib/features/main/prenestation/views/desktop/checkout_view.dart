import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/validator.dart';
import 'package:mybeshop/features/main/domain/entities/area.dart';
import 'package:mybeshop/features/main/domain/entities/city.dart';
import 'package:mybeshop/features/main/prenestation/controllers/checkout_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_select_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_text_form_field_widget.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mybeshop/features/main/prenestation/widgets/mobile/custom_divider.dart';

class CheckoutView extends GetResponsiveView {
  CheckoutView({super.key});

  @override
  Widget? desktop() {
    return const CheckoutDesktopView();
  }

  @override
  Widget? phone() {
    return GetBuilder<CheckoutController>(
        init: CheckoutController(
            Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: AppTheme.to.primaryColor,
              title: Text(
                "checkout".tr,
                style: AppStyles.bodyBoldM.copyWith(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    child: Form(
                      key: controller.checkoutForm,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.nameInput,
                                  validator: (v) {
                                    var message = Validator.validateRequired(
                                        v, "name".tr);
                                    if (message == null) {
                                      return Validator
                                          .networkValidatorErrorViewer(
                                              CheckoutController.to.errors,
                                              "name");
                                    }
                                    return message;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(LineAwesomeIcons.user),
                                    hintText: "name".tr,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.phoneInput,
                                  validator: (v) {
                                    var message = Validator.validateRequired(
                                        v, "phone".tr);
                                    if (message == null) {
                                      return Validator
                                          .networkValidatorErrorViewer(
                                              CheckoutController.to.errors,
                                              "phone");
                                    }
                                    return message;
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(LineAwesomeIcons.phone),
                                    hintText: "phone".tr,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Row(children: [
                            Expanded(
                              child: CheckoutController.to.stateLoading.value
                                  ? const LinearProgressIndicator()
                                  : CustomSearchableSelectWidget(
                                      enabled: CheckoutController
                                          .to.states.isNotEmpty,
                                      textStyle: AppStyles.bodyMediumM,
                                      leadingIcon:
                                          const Icon(LineAwesomeIcons.map),
                                      name: "state".tr,
                                      itemAsString: (v) => v.name,
                                      selectedItem:
                                          CheckoutController.to.selectedState,
                                      items: CheckoutController.to.states,
                                      onSelected: (v) => CheckoutController.to
                                          .onStateSelected(v),
                                    ),
                            ),
                          ]),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Expanded(
                                child: CheckoutController.to.citiesLoading.value
                                    ? const LinearProgressIndicator()
                                    : CustomSearchableSelectWidget(
                                        enabled: CheckoutController
                                            .to.cities.isNotEmpty,
                                        textStyle: AppStyles.bodyMediumM,
                                        leadingIcon: const Icon(
                                            LineAwesomeIcons.map_signs),
                                        name: "city".tr,
                                        itemAsString: (v) => v.name,
                                        selectedItem:
                                            CheckoutController.to.selectedCity,
                                        items: CheckoutController.to.cities,
                                        onSelected: (v) => CheckoutController.to
                                            .onCitySelected(v),
                                      ),
                              )
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              Expanded(
                                child: CheckoutController.to.areasLoading.value
                                    ? const LinearProgressIndicator()
                                    : CustomSearchableSelectWidget(
                                        enabled: CheckoutController
                                            .to.areas.isNotEmpty,
                                        textStyle: AppStyles.bodyMediumM,
                                        leadingIcon: const Icon(
                                            LineAwesomeIcons.map_marker),
                                        name: "area".tr,
                                        itemAsString: (v) => v.name,
                                        selectedItem:
                                            CheckoutController.to.selectedArea,
                                        items: CheckoutController.to.areas,
                                        onSelected: (v) => CheckoutController.to
                                            .onAreaSelected(v),
                                      ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller.deliveryAddressInput,
                                    validator: (v) {
                                      var message = Validator.validateRequired(
                                          v, "delivery_address".tr);
                                      if (message == null) {
                                        return Validator
                                            .networkValidatorErrorViewer(
                                                CheckoutController.to.errors,
                                                "delivery_address");
                                      }
                                      return message;
                                    },
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                          LineAwesomeIcons.map_marked),
                                      hintText: "delivery_address".tr,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const CustomDivider(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Text(
                      "payment_methods".tr,
                      style: AppStyles.bodyMediumM,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.r),
                      color: AppTheme.to.greyColor.withOpacity(0.09),
                    ),
                    child: Row(
                      children: [
                        Radio(
                          visualDensity:
                              const VisualDensity(horizontal: -3, vertical: -3),
                          value: "cash_on_delivery",
                          groupValue: controller.paymentMethod,
                          onChanged: (v) =>
                              controller.onPaymentMethodChanged(v),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "cash_on_delivery".tr,
                          style: AppStyles.bodyMediumM,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const CustomDivider(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: controller.couponFormKey,
                            child: TextFormField(
                              controller: controller.couponInput,
                              style: AppStyles.bodyMediumM,
                              decoration: InputDecoration(
                                hintText: "coupon".tr,
                                prefixIcon:
                                    const Icon(LineAwesomeIcons.percentage),
                              ),
                              validator: (v) {
                                return Validator.validateRequired(
                                    v, "coupon".tr);
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        MaterialButton(
                          height: 50.h,
                          minWidth: 120.w,
                          onPressed: () => controller.applyCoupon(),
                          color: AppTheme.to.primaryColor,
                          child: Text(
                            "apply".tr,
                            style: AppStyles.bodyMediumM
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Text(
                      "order_summery".tr,
                      style: AppStyles.bodyMediumM,
                    ),
                  ),
                  CheckoutOrderSummeryWidget(
                    name: "sub_total".tr,
                    value:
                        "${controller.shoppingCart?.subTotalFormattedAfterDiscount}",
                  ),
                  if (controller.shoppingCart != null &&
                      controller.shoppingCart!.coupon.valid) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "after_discount_applied".tr,
                            style: AppStyles.bodyMediumS
                                .copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                  CheckoutOrderSummeryWidget(
                    name: "tax".tr,
                    value: "${controller.shoppingCart?.taxFormatted}",
                  ),
                  CheckoutOrderSummeryWidget(
                    name: "delivery".tr,
                    value: "${controller.shoppingCart?.deliveryFees}",
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: MaterialButton(
                      height: 55.h,
                      minWidth: double.infinity,
                      color: AppTheme.to.primaryColor,
                      onPressed: () async {
                        controller.errors.clear();
                        if (controller.checkoutForm.currentState!.validate()) {
                          await controller.checkout(isMobile: true);
                        }
                      },
                      child: Text(
                        "checkout".tr,
                        style:
                            AppStyles.bodyMediumM.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CheckoutOrderSummeryWidget extends StatelessWidget {
  const CheckoutOrderSummeryWidget({
    required this.name,
    required this.value,
    this.valueColor,
    super.key,
  });
  final String name;
  final String value;
  final Color? valueColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: AppStyles.bodyRegularM.copyWith(
              color: AppTheme.to.greyColor.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                value,
                style: AppStyles.bodyRegularM.copyWith(
                  color: valueColor ?? AppTheme.to.greyColor.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutDesktopView extends StatelessWidget {
  const CheckoutDesktopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckoutController>(
          init: CheckoutController(
              Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
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
                      IgnorePointer(
                        ignoring: true,
                        child: TabBar(
                          labelStyle: AppStyles.bodyBoldXL
                              .copyWith(fontFamily: "Alexandria"),
                          labelColor: AppTheme.to.primaryColor,
                          controller: controller.tabController,
                          tabs: [
                            Tab(
                              icon: const Icon(LineAwesomeIcons.user),
                              text: "personal_information".tr,
                            ),
                            Tab(
                              icon: const Icon(LineAwesomeIcons.credit_card),
                              text: "payment_methods".tr,
                            ),
                            Tab(
                              icon: const Icon(LineAwesomeIcons.truck_moving),
                              text: "track_order".tr,
                            ),
                          ],
                          onTap: null,
                        ),
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
                      if (!controller.checkoutCompleted)
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
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
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
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      child: Text(
                                                        "${item?.priceFormatted}",
                                                        style:
                                                            AppStyles.bodyBoldL,
                                                      ),
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
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 20.h),
                          child: Row(
                            children: [
                              Expanded(
                                child: Form(
                                  key: controller.couponFormKey,
                                  child: TextFormField(
                                    controller: controller.couponInput,
                                    style: AppStyles.bodyBoldXL,
                                    decoration: InputDecoration(
                                      hintText: "coupon".tr,
                                      prefixIcon: const Icon(
                                          LineAwesomeIcons.percentage),
                                    ),
                                    validator: (v) {
                                      return Validator.validateRequired(
                                          v, "coupon".tr);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              MaterialButton(
                                height: 140.h,
                                minWidth: 120.w,
                                onPressed: () => controller.applyCoupon(),
                                color: AppTheme.to.primaryColor,
                                child: Text(
                                  "apply".tr,
                                  style: AppStyles.bodyMediumL
                                      .copyWith(color: Colors.white),
                                ),
                              )
                            ],
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
                                    "${controller.shoppingCart?.subTotalFormattedAfterDiscount}",
                              ),
                              if (controller.shoppingCart != null &&
                                  controller.shoppingCart!.coupon.valid) ...[
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "after_discount_applied".tr,
                                      style: AppStyles.bodyMediumS
                                          .copyWith(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ],
                              SizedBox(height: 10.h),
                              const Divider(),
                              SizedBox(
                                height: 10.h,
                              ),
                              OrderSummeryItemWidget(
                                name: "tax",
                                value:
                                    "${controller.shoppingCart?.taxFormatted}",
                              ),
                              // coupon

                              SizedBox(
                                height: 15.h,
                              ),
                              OrderSummeryItemWidget(
                                name: "delivery",
                                value:
                                    "${controller.shoppingCart?.deliveryFees}",
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
        Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            value,
            style: AppStyles.bodyMediumL.copyWith(color: Colors.grey),
          ),
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 80.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/lotties/checkout_completed.json",
                height: 700.h),
            SizedBox(height: 100.h),
            Text("checkout_completed".tr, style: AppStyles.heading3),
            SizedBox(height: 70.h),
            MaterialButton(
              color: AppTheme.to.primaryColor,
              onPressed: () {
                Get.back();
              },
              child: Text(
                "back_to_home".tr,
                style: AppStyles.bodyBoldXL.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
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
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Form(
                    key: controller.checkoutForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormFieldWidget(
                                controller: CheckoutController.to.nameInput,
                                label: "name".tr,
                                icon: LineAwesomeIcons.user,
                                validator: (v) {
                                  var message =
                                      Validator.validateRequired(v, "name".tr);
                                  if (message == null) {
                                    return Validator
                                        .networkValidatorErrorViewer(
                                            CheckoutController.to.errors,
                                            "name");
                                  }
                                  return message;
                                },
                              ),
                            ),
                            SizedBox(width: 40.w),
                            Expanded(
                              child: CustomTextFormFieldWidget(
                                controller: CheckoutController.to.phoneInput,
                                label: "phone".tr,
                                icon: LineAwesomeIcons.phone,
                                validator: (v) {
                                  var message =
                                      Validator.validateRequired(v, "phone".tr);
                                  if (message == null) {
                                    return Validator
                                        .networkValidatorErrorViewer(
                                            CheckoutController.to.errors,
                                            "phone");
                                  }
                                  return message;
                                },
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
                                  : CustomSearchableSelectWidget(
                                      enabled: controller.states.isNotEmpty,
                                      items: controller.states,
                                      leadingIcon:
                                          const Icon(LineAwesomeIcons.map),
                                      name: "state".tr,
                                      selectedItem: controller.selectedState,
                                      itemAsString: (v) => v.name,
                                      onSelected: (state) =>
                                          controller.onStateSelected(state),
                                    ),
                            ),
                            SizedBox(width: 40.w),
                            Expanded(
                              child: CheckoutController.to.citiesLoading.value
                                  ? const LinearProgressIndicator()
                                  : CustomSearchableSelectWidget<City>(
                                      enabled: controller.cities.isNotEmpty,
                                      items: controller.cities,
                                      leadingIcon: const Icon(
                                          LineAwesomeIcons.map_signs),
                                      name: "city".tr,
                                      selectedItem: controller.selectedCity,
                                      itemAsString: (v) => v.name,
                                      onSelected: (city) =>
                                          controller.onCitySelected(city),
                                    ),
                            ),
                            SizedBox(width: 40.w),
                            Expanded(
                              child: CheckoutController.to.areasLoading.value
                                  ? const LinearProgressIndicator()
                                  : CustomSearchableSelectWidget<Area>(
                                      enabled: controller.areas.isNotEmpty,
                                      items: controller.areas,
                                      leadingIcon: const Icon(
                                          LineAwesomeIcons.map_marked),
                                      name: "area".tr,
                                      selectedItem: controller.selectedArea,
                                      itemAsString: (v) => v.name,
                                      onSelected: (area) =>
                                          controller.onAreaSelected(area),
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
                                controller:
                                    CheckoutController.to.deliveryAddressInput,
                                maxLines: 4,
                                label: "delivery_address".tr,
                                icon: LineAwesomeIcons.map_marked,
                                validator: (v) {
                                  var message = Validator.validateRequired(
                                      v, "delivery_address".tr);
                                  if (message == null) {
                                    return Validator
                                        .networkValidatorErrorViewer(
                                            CheckoutController.to.errors,
                                            "delivery_address");
                                  }
                                  return message;
                                },
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
