import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mybeshop/core/theme/app_styles.dart';

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
    this.width,
    this.searchable = false,
  });
  final List<DropdownMenuEntry> items;
  final Function(dynamic)? onSelected;
  final String name;
  final Widget? leadingIcon;
  final TextStyle? textStyle;
  final bool enabled;
  final double horizontalMargin;
  final double? width;
  final bool searchable;
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
            width: width,
            enabled: enabled,
            leadingIcon: leadingIcon,
            enableSearch: searchable,
            requestFocusOnTap: false,
            dropdownMenuEntries: items,
            initialSelection: items.isNotEmpty ? items[0].value : null,
            textStyle: textStyle ?? AppStyles.bodyBoldL,
            onSelected: onSelected,
          ),
        ],
      ),
    );
  }
}

class CustomSearchableSelectWidget<T> extends StatelessWidget {
  const CustomSearchableSelectWidget(
      {super.key,
      required this.items,
      this.onSelected,
      required this.name,
      this.itemAsString,
      this.leadingIcon,
      this.textStyle,
      this.selectedItem,
      this.enabled = true});
  final List<T> items;
  final Function(T?)? onSelected;
  final String name;
  final String Function(T)? itemAsString;
  final Widget? leadingIcon;
  final TextStyle? textStyle;
  final T? selectedItem;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        name,
        style: textStyle ?? AppStyles.bodyBoldL,
      ),
      SizedBox(height: 20.h),
      DropdownSearch<T>(
        enabled: enabled,
        popupProps: const PopupProps.menu(
          showSelectedItems: false,
          showSearchBox: true,
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: textStyle ?? AppStyles.bodyBoldL,
        ),
        itemAsString: itemAsString,
        items: items,
        onChanged: onSelected,
        selectedItem: selectedItem,
      ),
    ]);
  }
}
