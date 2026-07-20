import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/widgets/riyal_price_text.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:mybeshop/features/main/domain/entities/order.dart';
import 'package:mybeshop/features/main/domain/entities/order_detail.dart';
import 'package:mybeshop/features/main/prenestation/controllers/track_orders_contorller.dart';
import 'package:mybeshop/features/main/prenestation/widgets/custom_text_form_field_widget.dart';
import 'package:mybeshop/features/main/prenestation/widgets/empty_widget.dart';

class TrackOrdersDesktopView extends StatelessWidget {
  const TrackOrdersDesktopView({super.key});

  static const double _maxContentWidth = 960;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackOrdersController>(
      init: TrackOrdersController(Get.find()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppTheme.to.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppTheme.to.surfaceColor,
            foregroundColor: AppTheme.to.textColor,
            title: Text('track_orders'.tr, style: AppStyles.heading5),
            leading: IconButton(
              onPressed: Get.back,
              icon: const Icon(LineAwesomeIcons.arrow_left),
            ),
          ),
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: _maxContentWidth.w),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SearchCard(controller: controller),
                      if (GlobalController.to.storeInfo?.ordersTrackingEnabled !=
                          false) ...[
                        SizedBox(height: 20.h),
                        _FilterChips(controller: controller),
                        SizedBox(height: 20.h),
                        _OrdersSection(controller: controller),
                      ] else ...[
                        SizedBox(height: 60.h),
                        Center(
                          child: Text(
                            'this_store_have_no_traking_service'.tr,
                            style: AppStyles.bodyBoldL,
                          ),
                        ),
                      ],
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

class _SearchCard extends StatelessWidget {
  const _SearchCard({required this.controller});

  final TrackOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.card(),
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('track_orders'.tr, style: AppStyles.heading6),
          SizedBox(height: 6.h),
          Text(
            'pleae_enter_phone_number_to_get_orders'.tr,
            style: AppStyles.bodyRegularS.copyWith(
              color: AppTheme.to.greyColor,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextFormFieldWidget(
                  controller: controller.searchInput,
                  icon: LineAwesomeIcons.phone,
                  iconSize: 20,
                  label: 'phone'.tr,
                  hint: '05xxxxxxxx',
                  keyboardType: TextInputType.phone,
                  onSubmitted: controller.onSearch,
                ),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                height: 56.h,
                child: FilledButton.icon(
                  onPressed: () => controller.onSearch(
                    controller.searchInput.text,
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.to.primaryColor,
                    foregroundColor: AppTheme.to.onPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDecorations.radiusM),
                    ),
                  ),
                  icon: Icon(LineAwesomeIcons.search, size: 16.sp),
                  label: Text('search'.tr, style: AppStyles.bodyBoldM),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips({required this.controller});

  final TrackOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < controller.filters.length; i++)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: _FilterChip(
                label: controller.filters[i].tr,
                selected: controller.tabController.index == i,
                onTap: () {
                  controller.tabController.index = i;
                  controller.update();
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: AppDecorations.pill(selected: selected),
          child: Text(
            label,
            style: AppStyles.bodyMediumS.copyWith(
              color:
                  selected ? AppTheme.to.textColor : AppTheme.to.greyColor,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrdersSection extends StatelessWidget {
  const _OrdersSection({required this.controller});

  final TrackOrdersController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.ordersLoading.value) {
      return SizedBox(
        height: 320.h,
        child: Center(
          child: CircularProgressIndicator(color: AppTheme.to.primaryColor),
        ),
      );
    }

    if (!controller.hasSearched) {
      return SizedBox(
        height: 320.h,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LineAwesomeIcons.phone_volume,
                size: 48.sp,
                color: AppTheme.to.greyColor.withOpacity(0.5),
              ),
              SizedBox(height: 12.h),
              Text(
                'pleae_enter_phone_number_to_get_orders'.tr,
                style: AppStyles.bodyMediumM.copyWith(
                  color: AppTheme.to.greyColor,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final selectedFilter = controller.filters[controller.tabController.index];
    final orders = selectedFilter == 'all'
        ? controller.orders
        : controller.orders
            .where((order) => order.status == selectedFilter)
            .toList();

    if (orders.isEmpty) {
      return SizedBox(
        height: 320.h,
        child: EmptyProductsWidget(message: 'no_orders_to_show'.tr),
      );
    }

    return Column(
      children: [
        for (final order in orders) _OrderCard(order: order),
      ],
    );
  }
}

Color _statusColor(String status) {
  switch (status) {
    case 'completed':
      return AppTheme.to.successColor;
    case 'cancelled':
      return AppTheme.to.saleColor;
    case 'new':
      return AppTheme.to.primaryColor;
    default:
      return AppTheme.to.blueGreyColor;
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(order.status);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: AppDecorations.card(),
      padding: EdgeInsets.all(20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppTheme.to.backgroundColor,
              borderRadius: BorderRadius.circular(AppDecorations.radiusM),
            ),
            child: Icon(
              LineAwesomeIcons.shopping_bag,
              color: AppTheme.to.primaryColor,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('#${order.no}', style: AppStyles.bodyBoldL),
                    SizedBox(width: 10.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        order.status.tr,
                        style: AppStyles.bodyMediumS.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(LineAwesomeIcons.user,
                        size: 16.sp, color: AppTheme.to.greyColor),
                    SizedBox(width: 6.w),
                    Text(
                      order.customer.name,
                      style: AppStyles.bodyRegularS.copyWith(
                        color: AppTheme.to.greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Wrap(
                  spacing: 24.w,
                  runSpacing: 6.h,
                  children: [
                    _SummaryValue(label: 'tax'.tr, amount: order.tax),
                    _SummaryValue(
                        label: 'delivery'.tr, amount: order.delivery),
                    _SummaryValue(
                        label: 'discount'.tr, amount: order.discount),
                    _SummaryValue(
                      label: 'total'.tr,
                      amount: order.total,
                      emphasized: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 160.w,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(160.w, 44.h),
                    foregroundColor: AppTheme.to.primaryColor,
                    side: BorderSide(color: AppTheme.to.borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDecorations.radiusM),
                    ),
                  ),
                  onPressed: () => _showOrderDetails(context, order),
                  child: Text('show_details'.tr, style: AppStyles.bodyMediumS),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 160.w,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(160.w, 44.h),
                    foregroundColor: AppTheme.to.primaryColor,
                    side: BorderSide(color: AppTheme.to.borderColor),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppDecorations.radiusM),
                    ),
                  ),
                  onPressed: () {
                    GlobalController.to.slug = order.no;
                    Get.offAllNamed(
                        "${AppRoutes.einvoice}/${GlobalController.to.slug}");
                  },
                  child:
                      Text('open_e_invoice'.tr, style: AppStyles.bodyMediumS),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Order order) {
    Get.dialog(
      Dialog(
        backgroundColor: AppTheme.to.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDecorations.radiusL),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 480.w, maxHeight: 560.h),
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('order_details'.tr, style: AppStyles.heading6),
                    IconButton(
                      onPressed: Get.back,
                      icon: Icon(Icons.close, color: AppTheme.to.greyColor),
                    ),
                  ],
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: order.details.length,
                    itemBuilder: (context, idx) {
                      final OrderDetail detail = order.details[idx];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppTheme.to.backgroundColor,
                          borderRadius:
                              BorderRadius.circular(AppDecorations.radiusM),
                        ),
                        padding: EdgeInsets.all(12.w),
                        margin: EdgeInsets.only(top: 12.h),
                        child: Row(
                          children: [
                            Container(
                              height: 48.w,
                              width: 48.w,
                              decoration: BoxDecoration(
                                color: AppTheme.to.surfaceColor,
                                borderRadius: BorderRadius.circular(
                                    AppDecorations.radiusS),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(detail.name,
                                      style: AppStyles.bodyBoldS),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "${"qty".tr}: ${detail.qty}",
                                    style: AppStyles.bodyRegularSS.copyWith(
                                      color: AppTheme.to.greyColor,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  RiyalPriceText(
                                    amount: detail.price,
                                    formatted: true,
                                    style: AppStyles.bodyMediumS,
                                  ),
                                ],
                              ),
                            ),
                            if (detail.cancelled != 0)
                              Text(
                                "${"cancelled".tr}: ${detail.cancelled}",
                                style: AppStyles.bodyRegularSS.copyWith(
                                  color: AppTheme.to.saleColor,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryValue extends StatelessWidget {
  const _SummaryValue({
    required this.label,
    required this.amount,
    this.emphasized = false,
  });

  final String label;
  final String amount;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppStyles.bodyRegularSS.copyWith(color: AppTheme.to.greyColor),
        ),
        SizedBox(height: 2.h),
        RiyalPriceText(
          amount: amount,
          formatted: true,
          style: emphasized
              ? AppStyles.bodyBoldS.copyWith(color: AppTheme.to.textColor)
              : AppStyles.bodyMediumS.copyWith(color: AppTheme.to.textColor),
        ),
      ],
    );
  }
}
