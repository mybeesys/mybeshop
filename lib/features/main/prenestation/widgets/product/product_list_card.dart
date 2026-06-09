import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/features/main/prenestation/widgets/shared_widgets_and_methods.dart';

class ProductListCard extends StatelessWidget {
  const ProductListCard({super.key, required this.product});

  final Product product;

  static const _placeholder =
      'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png';

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.hasDiscount == true;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDecorations.radiusM),
                  child: Container(
                    width: 88.w,
                    height: 88.w,
                    color: AppTheme.to.backgroundColor,
                    child: Image.network(
                      product.images.isNotEmpty
                          ? product.images.first
                          : _placeholder,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (hasDiscount)
                  Positioned(
                    top: 6.h,
                    left: 6.w,
                    child: _DiscountBadge(
                      label: '${product.discountPercent}%',
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: AppStyles.bodyBoldM,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          '${product.price} ${product.currency}',
                          style: AppStyles.bodyBoldM.copyWith(
                            color: AppTheme.to.primaryColor,
                          ),
                        ),
                      ),
                      if (hasDiscount) ...[
                        SizedBox(width: 8.w),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            product.originalPrice ?? '',
                            style: AppStyles.bodyRegularS.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppTheme.to.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (getHasExtrasOrVariantsText(product) != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      getHasExtrasOrVariantsText(product)!,
                      style: AppStyles.bodyRegularS.copyWith(
                        color: AppTheme.to.greyColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 8.w),
            addToCartMobileButton(product),
          ],
        ),
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  const _DiscountBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppTheme.to.saleColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppStyles.bodyBoldS.copyWith(color: Colors.white),
      ),
    );
  }
}
