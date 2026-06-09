import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_theme.dart';

class NavBarSocialMediaButtonWidget extends StatelessWidget {
  const NavBarSocialMediaButtonWidget({
    super.key,
    required this.icon,
    this.url,
    this.onPressed,
    this.verticalMargin = 0.0,
    this.compact = false,
  });

  final IconData icon;
  final Function()? onPressed;
  final double verticalMargin;
  final String? url;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final size = compact ? 36.w : 45.w;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: compact ? 4.w : 5.w,
        vertical: verticalMargin.h,
      ),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: compact
            ? AppTheme.to.backgroundColor
            : Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(compact ? 10.r : 0),
        border: compact
            ? Border.all(color: AppTheme.to.borderColor)
            : null,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(compact ? 10.r : 0),
        child: Icon(
          icon,
          size: compact ? 18.sp : 24.sp,
          color: compact ? AppTheme.to.primaryColor : Colors.white,
        ),
      ),
    );
  }
}
