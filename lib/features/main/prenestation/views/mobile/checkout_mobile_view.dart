import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/validator.dart';
import 'package:mybeshop/core/widgets/riyal_price_text.dart';
import 'package:mybeshop/features/main/domain/entities/shopping_cart.dart';
import 'package:mybeshop/features/main/prenestation/controllers/checkout_controller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_select_widget.dart';

class CheckoutMobileView extends StatelessWidget {
  const CheckoutMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      init: CheckoutController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
      builder: (controller) {
        final cart = controller.shoppingCart;

        return Scaffold(
          backgroundColor: AppTheme.to.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppTheme.to.primaryColor,
            foregroundColor: AppTheme.to.onPrimaryColor,
            title: Text(
              'checkout'.tr,
              style: AppStyles.bodyBoldM.copyWith(
                color: AppTheme.to.onPrimaryColor,
              ),
            ),
          ),
          body: cart == null
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppTheme.to.primaryColor,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                        child: Form(
                          key: controller.checkoutForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _CheckoutSection(
                                icon: LineAwesomeIcons.user_circle,
                                title: 'personal_information'.tr,
                                child: Column(
                                  children: [
                                    _CheckoutTextField(
                                      controller: controller.nameInput,
                                      hint: 'name'.tr,
                                      icon: LineAwesomeIcons.user,
                                      validator: (v) {
                                        final message = Validator.validateRequired(
                                            v, 'name'.tr);
                                        if (message == null) {
                                          return Validator
                                              .networkValidatorErrorViewer(
                                            controller.errors,
                                            'name',
                                          );
                                        }
                                        return message;
                                      },
                                    ),
                                    SizedBox(height: 12.h),
                                    _CheckoutTextField(
                                      controller: controller.phoneInput,
                                      hint: 'EXP: 966557013119',
                                      icon: LineAwesomeIcons.phone,
                                      keyboardType: TextInputType.phone,
                                      validator: (v) {
                                        final message = Validator.validateRequired(
                                            v, 'phone'.tr);
                                        if (message == null) {
                                          return Validator
                                              .networkValidatorErrorViewer(
                                            controller.errors,
                                            'phone',
                                          );
                                        }
                                        return message;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              _CheckoutSection(
                                icon: LineAwesomeIcons.map_marked,
                                title: 'address_info'.tr,
                                child: Column(
                                  children: [
                                    _LocationSelect(
                                      loading: controller.stateLoading.value,
                                      child: CustomSearchableSelectWidget(
                                        enabled: controller.states.isNotEmpty,
                                        textStyle: AppStyles.bodyMediumM,
                                        leadingIcon: Icon(
                                          LineAwesomeIcons.map,
                                          size: 18.sp,
                                          color: AppTheme.to.greyColor,
                                        ),
                                        name: 'state'.tr,
                                        itemAsString: (v) => v.name,
                                        selectedItem: controller.selectedState,
                                        items: controller.states,
                                        onSelected: controller.onStateSelected,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    _LocationSelect(
                                      loading: controller.citiesLoading.value,
                                      child: CustomSearchableSelectWidget(
                                        enabled: controller.cities.isNotEmpty,
                                        textStyle: AppStyles.bodyMediumM,
                                        leadingIcon: Icon(
                                          LineAwesomeIcons.city,
                                          size: 18.sp,
                                          color: AppTheme.to.greyColor,
                                        ),
                                        name: 'city'.tr,
                                        itemAsString: (v) => v.name,
                                        selectedItem: controller.selectedCity,
                                        items: controller.cities,
                                        onSelected: controller.onCitySelected,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    _LocationSelect(
                                      loading: controller.areasLoading.value,
                                      child: CustomSearchableSelectWidget(
                                        enabled: controller.areas.isNotEmpty,
                                        textStyle: AppStyles.bodyMediumM,
                                        leadingIcon: Icon(
                                          LineAwesomeIcons.map_marker,
                                          size: 18.sp,
                                          color: AppTheme.to.greyColor,
                                        ),
                                        name: 'area'.tr,
                                        itemAsString: (v) => v.name,
                                        selectedItem: controller.selectedArea,
                                        items: controller.areas,
                                        onSelected: controller.onAreaSelected,
                                      ),
                                    ),
                                    SizedBox(height: 12.h),
                                    _CheckoutTextField(
                                      controller:
                                          controller.deliveryAddressInput,
                                      hint: 'delivery_address'.tr,
                                      icon: LineAwesomeIcons.map_marked,
                                      maxLines: 3,
                                      validator: (v) {
                                        final message = Validator.validateRequired(
                                            v, 'delivery_address'.tr);
                                        if (message == null) {
                                          return Validator
                                              .networkValidatorErrorViewer(
                                            controller.errors,
                                            'delivery_address',
                                          );
                                        }
                                        return message;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              _CheckoutSection(
                                icon: LineAwesomeIcons.wallet,
                                title: 'payment_methods'.tr,
                                child: _PaymentMethodTile(
                                  selected: controller.paymentMethod ==
                                      'cash_on_delivery',
                                  onTap: () => controller
                                      .onPaymentMethodChanged('cash_on_delivery'),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              _CheckoutSection(
                                icon: LineAwesomeIcons.tag,
                                title: 'coupon'.tr,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Form(
                                        key: controller.couponFormKey,
                                        child: _CheckoutTextField(
                                          controller: controller.couponInput,
                                          hint: 'coupon'.tr,
                                          icon: LineAwesomeIcons.percentage,
                                          validator: (v) =>
                                              Validator.validateRequired(
                                                  v, 'coupon'.tr),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    SizedBox(
                                      height: 48.h,
                                      child: ElevatedButton(
                                        onPressed: controller.applyCoupon,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppTheme.to.primaryColor,
                                          foregroundColor:
                                              AppTheme.to.onPrimaryColor,
                                          elevation: 0,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16.w,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              AppDecorations.radiusM,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          'apply'.tr,
                                          style: AppStyles.bodyBoldM.copyWith(
                                            color: AppTheme.to.onPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              _OrderSummaryCard(cart: cart),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _CheckoutSubmitBar(
                      cart: cart,
                      onSubmit: () async {
                        controller.errors.clear();
                        if (controller.checkoutForm.currentState!.validate()) {
                          await controller.checkout(isMobile: true);
                        }
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({
    required this.icon,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppTheme.to.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  size: 18.sp,
                  color: AppTheme.to.primaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              Text(title, style: AppStyles.bodyBoldM),
            ],
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }
}

class _CheckoutTextField extends StatelessWidget {
  const _CheckoutTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.validator,
    this.maxLines = 1,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppStyles.bodyMediumM,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppStyles.bodyRegularS.copyWith(
          color: AppTheme.to.greyColor.withOpacity(0.7),
        ),
        filled: true,
        fillColor: AppTheme.to.backgroundColor,
        prefixIcon: Icon(icon, size: 18.sp, color: AppTheme.to.greyColor),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusM),
          borderSide: BorderSide(color: AppTheme.to.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusM),
          borderSide: BorderSide(color: AppTheme.to.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusM),
          borderSide: BorderSide(color: AppTheme.to.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusM),
          borderSide: BorderSide(color: AppTheme.to.saleColor),
        ),
      ),
    );
  }
}

class _LocationSelect extends StatelessWidget {
  const _LocationSelect({required this.loading, required this.child});

  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return SizedBox(
        height: 48.h,
        child: Center(
          child: SizedBox(
            width: 22.w,
            height: 22.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppTheme.to.primaryColor,
            ),
          ),
        ),
      );
    }
    return child;
  }
}

class _PaymentMethodTile extends StatelessWidget {
  const _PaymentMethodTile({
    required this.selected,
    required this.onTap,
  });

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDecorations.radiusM),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: selected
                ? AppTheme.to.primaryColor.withOpacity(0.12)
                : AppTheme.to.backgroundColor,
            borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            border: Border.all(
              color: selected
                  ? AppTheme.to.primaryColor
                  : AppTheme.to.borderColor,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppTheme.to.surfaceColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Image.asset(
                  'assets/images/cod.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'cash_on_delivery'.tr,
                  style: AppStyles.bodyMediumM.copyWith(
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? AppTheme.to.primaryColor
                      : Colors.transparent,
                  border: Border.all(
                    color: selected
                        ? AppTheme.to.primaryColor
                        : AppTheme.to.greyColor.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: selected
                    ? Icon(
                        Icons.check_rounded,
                        size: 14.sp,
                        color: AppTheme.to.onPrimaryColor,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.cart});

  final ShoppingCart cart;

  bool _looksLikePrice(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    return RegExp(r'[\d]').hasMatch(trimmed) &&
        !RegExp(r'[a-zA-Z\u0600-\u06FF]{4,}').hasMatch(trimmed);
  }

  @override
  Widget build(BuildContext context) {
    final total = (cart.subTotal + cart.tax).toStringAsFixed(2);

    return Container(
      decoration: AppDecorations.card(),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppTheme.to.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  LineAwesomeIcons.receipt,
                  size: 18.sp,
                  color: AppTheme.to.primaryColor,
                ),
              ),
              SizedBox(width: 10.w),
              Text('order_summery'.tr, style: AppStyles.bodyBoldM),
            ],
          ),
          SizedBox(height: 14.h),
          _SummaryLine(
            label: 'sub_total'.tr,
            value: cart.subTotalFormattedAfterDiscount,
            isPrice: true,
          ),
          if (cart.coupon.valid) ...[
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
          _SummaryLine(
            label: 'tax'.tr,
            value: cart.taxFormatted,
            isPrice: true,
          ),
          SizedBox(height: 8.h),
          _SummaryLine(
            label: 'delivery'.tr,
            value: cart.deliveryFees,
            isPrice: _looksLikePrice(cart.deliveryFees),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(color: AppTheme.to.borderColor, height: 1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('total'.tr, style: AppStyles.bodyBoldM),
              RiyalPriceText(
                amount: total,
                style: AppStyles.bodyBoldM.copyWith(
                  color: AppTheme.to.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  const _SummaryLine({
    required this.label,
    required this.value,
    required this.isPrice,
  });

  final String label;
  final String value;
  final bool isPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: AppStyles.bodyRegularS.copyWith(
              color: AppTheme.to.greyColor,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: isPrice
              ? RiyalPriceText(
                  amount: value,
                  formatted: true,
                  style: AppStyles.bodyMediumM,
                  textAlign: TextAlign.end,
                )
              : Text(
                  value,
                  style: AppStyles.bodyRegularS.copyWith(
                    color: AppTheme.to.greyColor,
                  ),
                  textAlign: TextAlign.end,
                ),
        ),
      ],
    );
  }
}

class _CheckoutSubmitBar extends StatelessWidget {
  const _CheckoutSubmitBar({
    required this.cart,
    required this.onSubmit,
  });

  final ShoppingCart cart;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final total = (cart.subTotal + cart.tax).toStringAsFixed(2);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.to.surfaceColor,
        border: Border(top: BorderSide(color: AppTheme.to.borderColor)),
        boxShadow: AppDecorations.elevatedShadow,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'total'.tr,
                      style: AppStyles.bodyRegularS.copyWith(
                        color: AppTheme.to.greyColor,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    RiyalPriceText(
                      amount: total,
                      style: AppStyles.heading5.copyWith(
                        color: AppTheme.to.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.to.primaryColor,
                      foregroundColor: AppTheme.to.onPrimaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDecorations.radiusL),
                      ),
                    ),
                    child: Text(
                      'checkout'.tr,
                      style: AppStyles.bodyBoldM.copyWith(
                        color: AppTheme.to.onPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
