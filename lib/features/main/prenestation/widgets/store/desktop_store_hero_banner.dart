import 'package:flutter/material.dart';
import 'package:mybeshop/core/widgets/app_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/extenstions.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';

class DesktopStoreHeroBanner extends StatelessWidget {
  const DesktopStoreHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final store = GlobalController.to.storeInfo;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 220.h),
      decoration: AppDecorations.heroBanner(),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            top: -60.w,
            right: -60.w,
            child: _blob(220.w, AppTheme.to.primaryColor.withOpacity(0.10)),
          ),
          Positioned(
            bottom: -80.w,
            right: 160.w,
            child: _blob(160.w, AppTheme.to.primaryColor.withOpacity(0.06)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 32.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        store?.heroTitle ?? store?.name ?? '',
                        style: AppStyles.heading3.copyWith(
                          color: AppTheme.to.textColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (store != null && store.bio.isNotEmpty) ...[
                        SizedBox(height: 14.h),
                        Text(
                          store.bio.removeHtmlTags(),
                          style: AppStyles.bodyRegularM.copyWith(
                            color: AppTheme.to.greyColor,
                            height: 1.7,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 40.w),
                Expanded(
                  flex: 4,
                  child: _HeroImage(cover: store?.cover),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.cover});

  final String? cover;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: 16.h,
            child: Transform.rotate(
              angle: -0.05,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppTheme.to.primaryColor.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(AppDecorations.radiusL),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDecorations.radiusL),
              boxShadow: AppDecorations.elevatedShadow,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDecorations.radiusL),
              child: Container(
                color: AppTheme.to.surfaceColor,
                child: cover != null
                    ? AppNetworkImage(
                        imageUrl: cover!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() => Center(
        child: Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.contain,
        ),
      );
}
