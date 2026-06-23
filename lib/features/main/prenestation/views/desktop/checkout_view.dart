import 'package:flutter/material.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/widgets/app_network_image.dart';
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
import 'package:mybeshop/core/widgets/riyal_price_text.dart';
import 'package:mybeshop/features/main/prenestation/views/mobile/checkout_mobile_view.dart';

class CheckoutView extends GetResponsiveView {
  CheckoutView({super.key});

  @override
  Widget? desktop() {
    return const CheckoutDesktopView();
  }

  @override
  Widget? phone() => const CheckoutMobileView();
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
            child: RiyalPriceText(
              amount: value,
              formatted: true,
              style: AppStyles.bodyRegularM.copyWith(
                color: valueColor ?? AppTheme.to.greyColor.withOpacity(0.8),
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
    return ScreenUtilInit(
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, __) => const _CheckoutDesktopBody(),
    );
  }
}

class _CheckoutDesktopBody extends StatelessWidget {
  const _CheckoutDesktopBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.to.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.to.surfaceColor,
        foregroundColor: AppTheme.to.textColor,
        title: Text('checkout'.tr, style: AppStyles.heading5),
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(LineAwesomeIcons.arrow_left),
        ),
      ),
      body: GetBuilder<CheckoutController>(
        init: CheckoutController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
        ),
        builder: (controller) {
          final topInset = MediaQuery.paddingOf(context).top + kToolbarHeight;
          return SizedBox(
            height: MediaQuery.sizeOf(context).height - topInset,
            child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200.w),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 24.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _CheckoutFormPanel(controller: controller),
                    ),
                    SizedBox(width: 24.w),
                    SizedBox(
                      width: 360.w,
                      child: _CheckoutSummaryPanel(controller: controller),
                    ),
                  ],
                ),
              ),
            ),
            ),
          );
        },
      ),
    );
  }
}

class _CheckoutFormPanel extends StatelessWidget {
  const _CheckoutFormPanel({required this.controller});

  final CheckoutController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card(),
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IgnorePointer(
            ignoring: true,
            child: TabBar(
              labelStyle: AppStyles.bodyBoldM,
              unselectedLabelStyle: AppStyles.bodyMediumS,
              labelColor: AppTheme.to.primaryColor,
              unselectedLabelColor: AppTheme.to.greyColor,
              indicatorColor: AppTheme.to.primaryColor,
              controller: controller.tabController,
              tabs: [
                Tab(
                  icon: Icon(LineAwesomeIcons.user, size: 18.sp),
                  text: 'personal_information'.tr,
                ),
                Tab(
                  icon: Icon(LineAwesomeIcons.credit_card, size: 18.sp),
                  text: 'payment_methods'.tr,
                ),
                Tab(
                  icon: Icon(LineAwesomeIcons.truck_moving, size: 18.sp),
                  text: 'track_order'.tr,
                ),
              ],
              onTap: null,
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: controller.steps,
            ),
          ),
          if (!controller.checkoutCompleted) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                if (controller.tabController.index > 0)
                  OutlinedButton(
                    onPressed: () => controller.onStepChanged(false),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(120.w, 48.h),
                      foregroundColor: AppTheme.to.textColor,
                      side: BorderSide(color: AppTheme.to.borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDecorations.radiusM),
                      ),
                    ),
                    child: Text('previus'.tr, style: AppStyles.bodyBoldM),
                  ),
                if (controller.tabController.index > 0) SizedBox(width: 12.w),
                if (controller.tabController.index < 2)
                  FilledButton(
                    onPressed: () => controller.onStepChanged(true),
                    style: FilledButton.styleFrom(
                      minimumSize: Size(140.w, 48.h),
                      backgroundColor: AppTheme.to.primaryColor,
                      foregroundColor: AppTheme.to.onPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDecorations.radiusM),
                      ),
                    ),
                    child: Text('next'.tr, style: AppStyles.bodyBoldM),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _CheckoutSummaryPanel extends StatelessWidget {
  const _CheckoutSummaryPanel({required this.controller});

  final CheckoutController controller;

  @override
  Widget build(BuildContext context) {
    final cart = controller.shoppingCart;

    return Container(
      decoration: AppDecorations.card(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
            child: Row(
              children: [
                Expanded(
                  child: Text('order_summery'.tr, style: AppStyles.heading5),
                ),
                Text(
                  intl.DateFormat('EEE, M/d/y').format(DateTime.now()),
                  style: AppStyles.bodyRegularS.copyWith(
                    color: AppTheme.to.greyColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cart?.items.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = cart!.items[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppTheme.to.backgroundColor,
                          borderRadius:
                              BorderRadius.circular(AppDecorations.radiusM),
                          border: Border.all(color: AppTheme.to.borderColor),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: SizedBox(
                                width: 56.w,
                                height: 56.w,
                                child: AppNetworkImage(
                                  imageUrl: item.image ??
                                      'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: AppStyles.bodyBoldM,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${'qty'.tr}: ${item.qty}',
                                    style: AppStyles.bodyRegularS.copyWith(
                                      color: AppTheme.to.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RiyalPriceText(
                              amount: item.priceFormatted,
                              formatted: true,
                              style: AppStyles.bodyBoldM.copyWith(
                                color: AppTheme.to.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  Form(
                    key: controller.couponFormKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.couponInput,
                            style: AppStyles.bodyMediumM,
                            decoration: InputDecoration(
                              hintText: 'coupon'.tr,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 14.h,
                              ),
                              prefixIcon: Icon(
                                LineAwesomeIcons.percentage,
                                size: 18.sp,
                                color: AppTheme.to.greyColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDecorations.radiusM,
                                ),
                              ),
                            ),
                            validator: (v) =>
                                Validator.validateRequired(v, 'coupon'.tr),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        SizedBox(
                          height: 48.h,
                          child: FilledButton(
                            onPressed: controller.applyCoupon,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.to.primaryColor,
                              foregroundColor: AppTheme.to.onPrimaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDecorations.radiusM,
                                ),
                              ),
                            ),
                            child: Text('apply'.tr, style: AppStyles.bodyBoldM),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
            child: Column(
              children: [
                const Divider(),
                SizedBox(height: 12.h),
                OrderSummeryItemWidget(
                  name: 'sub_total',
                  value: cart?.subTotalFormattedAfterDiscount ?? '',
                ),
                if (cart != null && cart.coupon.valid) ...[
                  SizedBox(height: 8.h),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      'after_discount_applied'.tr,
                      style: AppStyles.bodyRegularS.copyWith(
                        color: AppTheme.to.successColor,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 8.h),
                OrderSummeryItemWidget(
                  name: 'tax',
                  value: cart?.taxFormatted ?? '',
                ),
                SizedBox(height: 8.h),
                OrderSummeryItemWidget(
                  name: 'delivery',
                  value: cart?.deliveryFees ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
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
        Text(name.tr, style: AppStyles.bodyMediumM),
        Flexible(
          child: RiyalPriceText(
            amount: value,
            formatted: true,
            textAlign: TextAlign.end,
            style: AppStyles.bodyMediumM.copyWith(
              color: AppTheme.to.greyColor,
            ),
          ),
        ),
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
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
        height: 140.w,
        width: 140.w,
        decoration: BoxDecoration(
            color: isSelected ? AppTheme.to.primaryColor : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              SizedBox(
                height: 72.w,
                width: 72.w,
                child: Image.asset(icon),
              ),
              SizedBox(height: 10.h),
              Text(
                name,
                style: AppStyles.bodyBoldL.copyWith(
                    color:
                        isSelected
                            ? AppTheme.to.onPrimaryColor
                            : AppTheme.to.primaryColor),
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/checkout_completed.json',
              height: 220.h,
            ),
            SizedBox(height: 24.h),
            Text('checkout_completed'.tr, style: AppStyles.heading4),
            SizedBox(height: 24.h),
            FilledButton(
              onPressed: () => CheckoutController.to.goHomeAfterCheckout(),
              style: FilledButton.styleFrom(
                minimumSize: Size(180.w, 48.h),
                backgroundColor: AppTheme.to.primaryColor,
                foregroundColor: AppTheme.to.onPrimaryColor,
              ),
              child: Text(
                'back_to_home'.tr,
                style: AppStyles.bodyBoldM,
              ),
            ),
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
            child: Form(
              key: controller.checkoutForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormFieldWidget(
                          controller: CheckoutController.to.nameInput,
                          label: 'name'.tr,
                          icon: LineAwesomeIcons.user,
                          validator: (v) {
                            var message =
                                Validator.validateRequired(v, 'name'.tr);
                            if (message == null) {
                              return Validator.networkValidatorErrorViewer(
                                CheckoutController.to.errors,
                                'name',
                              );
                            }
                            return message;
                          },
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CustomTextFormFieldWidget(
                          controller: CheckoutController.to.phoneInput,
                          label: 'phone'.tr,
                          icon: LineAwesomeIcons.phone,
                          hint: 'EXP: 966557013119',
                          validator: (v) {
                            var message =
                                Validator.validateRequired(v, 'phone'.tr);
                            if (message == null) {
                              return Validator.networkValidatorErrorViewer(
                                CheckoutController.to.errors,
                                'phone',
                              );
                            }
                            return message;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'address_info'.tr,
                    style: AppStyles.heading6,
                  ),
                  SizedBox(height: 16.h),
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
                                name: 'state'.tr,
                                selectedItem: controller.selectedState,
                                itemAsString: (v) => v.name,
                                onSelected: (state) =>
                                    controller.onStateSelected(state),
                              ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CheckoutController.to.citiesLoading.value
                            ? const LinearProgressIndicator()
                            : CustomSearchableSelectWidget<City>(
                                enabled: controller.cities.isNotEmpty,
                                items: controller.cities,
                                leadingIcon: const Icon(
                                    LineAwesomeIcons.map_signs),
                                name: 'city'.tr,
                                selectedItem: controller.selectedCity,
                                itemAsString: (v) => v.name,
                                onSelected: (city) =>
                                    controller.onCitySelected(city),
                              ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CheckoutController.to.areasLoading.value
                            ? const LinearProgressIndicator()
                            : CustomSearchableSelectWidget<Area>(
                                enabled: controller.areas.isNotEmpty,
                                items: controller.areas,
                                leadingIcon: const Icon(
                                    LineAwesomeIcons.map_marked),
                                name: 'area'.tr,
                                selectedItem: controller.selectedArea,
                                itemAsString: (v) => v.name,
                                onSelected: (area) =>
                                    controller.onAreaSelected(area),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormFieldWidget(
                    controller: CheckoutController.to.deliveryAddressInput,
                    maxLines: 3,
                    label: 'delivery_address'.tr,
                    icon: LineAwesomeIcons.map_marked,
                    validator: (v) {
                      var message = Validator.validateRequired(
                          v, 'delivery_address'.tr);
                      if (message == null) {
                        return Validator.networkValidatorErrorViewer(
                          CheckoutController.to.errors,
                          'delivery_address',
                        );
                      }
                      return message;
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
