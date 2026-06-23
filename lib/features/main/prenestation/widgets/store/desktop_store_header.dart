import 'package:flutter/material.dart';
import 'package:mybeshop/core/widgets/app_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/config/app_routes.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DesktopStoreHeader extends StatelessWidget {
  const DesktopStoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final store = GlobalController.to.storeInfo;
    final locale = GlobalController.to.currentLocale.languageCode;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.to.surfaceColor,
        border: Border(bottom: BorderSide(color: AppTheme.to.borderColor)),
        boxShadow: AppDecorations.cardShadow,
      ),
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1280.w),
          child: Row(
            children: [
              _Logo(store?.logo),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store?.name ?? '',
                      style: AppStyles.bodyBoldL,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (store?.heroTitle.isNotEmpty == true &&
                        store!.heroTitle != store.name)
                      Text(
                        store.heroTitle,
                        style: AppStyles.bodyRegularS.copyWith(
                          color: AppTheme.to.greyColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              if (store?.phone.isNotEmpty == true)
                _HeaderAction(
                  icon: LineAwesomeIcons.phone,
                  label: store!.phone,
                  onTap: () => launchUrlString('tel:${store.phone}'),
                ),
              if (store?.ordersTrackingEnabled == true) ...[
                SizedBox(width: 8.w),
                FilledButton.icon(
                  onPressed: () => Get.toNamed(AppRoutes.trackOrders),
                  icon: Icon(Icons.local_shipping_outlined, size: 18.sp),
                  label: Text('track_orders'.tr),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.to.primaryColor,
                    foregroundColor: AppTheme.to.textColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  ),
                ),
              ],
              SizedBox(width: 8.w),
              OutlinedButton(
                onPressed: () => GlobalController.to
                    .changeCurrentLanguage(locale == 'ar' ? 'en' : 'ar'),
                child: Text(locale == 'ar' ? 'english'.tr : 'arabic'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo(this.url);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDecorations.radiusM),
      child: Container(
        width: 48.w,
        height: 48.w,
        color: AppTheme.to.backgroundColor,
        child: url != null
            ? AppNetworkImage(imageUrl: url!, fit: BoxFit.cover)
            : Icon(LineAwesomeIcons.store, color: AppTheme.to.primaryColor),
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18.sp, color: AppTheme.to.greyColor),
      label: Text(
        label,
        style: AppStyles.bodyRegularS.copyWith(color: AppTheme.to.greyColor),
      ),
    );
  }
}
