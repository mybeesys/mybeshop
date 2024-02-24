import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget(
      {super.key,
      required this.icon,
      required this.label,
      this.controller,
      this.maxLines = 1,
      this.iconSize = 40,
      this.textStyle,
      this.keyboardType});
  final IconData icon;
  final String label;
  final TextEditingController? controller;
  final int maxLines;
  final double iconSize;
  final TextStyle? textStyle;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(
          label,
        ),
        prefixIcon: Icon(
          icon,
          size: iconSize.sp,
        ),
      ),
    );
  }
}
