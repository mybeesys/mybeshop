import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/core/utils/helper/extenstions.dart';
import 'package:mybeshop/features/global/presentation/global_controller.dart';

class StoreHeroBanner extends StatelessWidget {
  const StoreHeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final store = GlobalController.to.storeInfo;
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
      decoration: AppDecorations.heroBanner(),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -20.w,
            top: -20.h,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDecorations.radiusM),
                  child: Container(
                    width: 88.w,
                    height: 88.w,
                    color: Colors.white,
                    child: store?.cover != null
                        ? Image.network(store!.cover!, fit: BoxFit.cover)
                        : Image.asset('assets/images/bg.png', fit: BoxFit.contain),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store?.heroTitle ?? store?.name ?? '',
                        style: AppStyles.bodyBoldL.copyWith(
                          color: AppTheme.to.textColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (store != null && store.bio.isNotEmpty) ...[
                        SizedBox(height: 6.h),
                        Text(
                          store.bio.removeHtmlTags(),
                          style: AppStyles.bodyRegularS.copyWith(
                            color: AppTheme.to.greyColor,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
