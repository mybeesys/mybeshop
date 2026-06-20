import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_decorations.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/domain/entities/product.dart';
import 'package:mybeshop/core/widgets/riyal_price_text.dart';
import 'package:mybeshop/features/main/prenestation/widgets/shared_widgets_and_methods.dart';

const _placeholder =
    'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-15.png';

class DesktopListProductCard extends StatelessWidget {
  const DesktopListProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.hasDiscount == true;
    return Container(
      height: 120.h,
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          _ProductImage(
            url: product.images.isNotEmpty ? product.images.first : _placeholder,
            width: 120.w,
            height: 120.h,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(AppDecorations.radiusL),
            ),
            discount: hasDiscount ? '${product.discountPercent}%' : null,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(product.name, style: AppStyles.bodyBoldM, maxLines: 2),
                  SizedBox(height: 6.h),
                  _PriceRow(product: product),
                  if (getHasExtrasOrVariantsText(product) != null)
                    Text(
                      getHasExtrasOrVariantsText(product)!,
                      style: AppStyles.bodyRegularS.copyWith(
                        color: AppTheme.to.greyColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: addToCartButton(product, height: 44.h, width: 120.w),
          ),
        ],
      ),
    );
  }
}

class DesktopGridProductCard extends StatelessWidget {
  const DesktopGridProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = product.hasDiscount == true;
    return Container(
      decoration: AppDecorations.card(),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ProductImage(
            url: product.images.isNotEmpty ? product.images.first : _placeholder,
            height: 140.h,
            width: double.infinity,
            discount: hasDiscount ? '${product.discountPercent}%' : null,
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: AppStyles.bodyBoldM, maxLines: 2),
                SizedBox(height: 6.h),
                _PriceRow(product: product),
                SizedBox(height: 10.h),
                addToCartButton(product, height: 40.h, width: double.infinity),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RiyalPriceText(
          amount: '${product.price}',
          currency: product.currency,
          style: AppStyles.bodyBoldM.copyWith(color: AppTheme.to.primaryColor),
        ),
        if (product.hasDiscount == true) ...[
          SizedBox(width: 8.w),
          RiyalPriceText(
            amount: product.originalPrice ?? '',
            currency: product.currency,
            style: AppStyles.bodyRegularS.copyWith(
              decoration: TextDecoration.lineThrough,
              color: AppTheme.to.greyColor,
            ),
          ),
        ],
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.url,
    required this.width,
    this.height,
    this.borderRadius,
    this.discount,
  });

  final String url;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final String? discount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: Container(
            width: width,
            height: height,
            color: AppTheme.to.backgroundColor,
            child: Image.network(url, fit: BoxFit.cover),
          ),
        ),
        if (discount != null)
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppTheme.to.saleColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                discount!,
                style: AppStyles.bodyBoldS.copyWith(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
