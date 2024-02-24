import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';

class CustomSelectWidget extends StatelessWidget {
  const CustomSelectWidget({
    super.key,
    required this.name,
    required this.items,
    this.onSelected,
    this.leadingIcon,
    this.textStyle,
    this.enabled = true,
    this.horizontalMargin = 10,
  });
  final List<DropdownMenuEntry> items;
  final Function(dynamic)? onSelected;
  final String name;
  final Widget? leadingIcon;
  final TextStyle? textStyle;
  final bool enabled;
  final double horizontalMargin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: textStyle ?? AppStyles.bodyBoldL,
          ),
          SizedBox(height: 20.h),
          DropdownMenu(
            enabled: enabled,
            leadingIcon: leadingIcon,
            enableSearch: false,
            requestFocusOnTap: false,
            dropdownMenuEntries: items,
            initialSelection: items.isNotEmpty ? items[0].value : null,
            textStyle: AppStyles.bodyBoldL,
            onSelected: onSelected,
          ),
        ],
      ),
    );
  }
}
