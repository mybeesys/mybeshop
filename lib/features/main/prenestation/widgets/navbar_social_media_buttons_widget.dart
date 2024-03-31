import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_theme.dart';

class NavBarSocialMediaButtonWidget extends StatelessWidget {
  const NavBarSocialMediaButtonWidget(
      {super.key,
      required this.icon,
      this.onPressed,
      this.verticalMargin = 0.0});
  final IconData icon;
  final Function()? onPressed;
  final double verticalMargin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: verticalMargin.h),
      width: 45.w,
      height: 45.w,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: InkWell(
          onTap: onPressed,
          child: Icon(
            icon,
            size: 24.sp,
            color: AppTheme.to.primaryColor,
          )),
    );
  }
}
