import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_theme.dart';
import 'package:mybeshop/features/main/prenestation/controllers/mobile/view_contorller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  static const _items = [
    _NavItemData(
      labelKey: 'home',
      outlinedIcon: LineAwesomeIcons.home,
      filledIcon: LineAwesomeIcons.home,
      color: Color(0xFFF59E0B),
    ),
    _NavItemData(
      labelKey: 'cart',
      outlinedIcon: LineAwesomeIcons.shopping_cart,
      filledIcon: LineAwesomeIcons.shopping_cart,
      color: Color(0xFF6366F1),
    ),
    _NavItemData(
      labelKey: 'orders',
      outlinedIcon: LineAwesomeIcons.boxes,
      filledIcon: LineAwesomeIcons.boxes,
      color: Color(0xFF10B981),
    ),
    _NavItemData(
      labelKey: 'settings',
      outlinedIcon: LineAwesomeIcons.cog,
      filledIcon: LineAwesomeIcons.cog,
      color: Color(0xFF2563EB),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewController>(
      init: Get.find<ViewController>(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.to.surfaceColor,
            border: Border(top: BorderSide(color: AppTheme.to.borderColor)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 6.h),
              child: Row(
                children: List.generate(_items.length, (index) {
                  return Expanded(
                    child: _NavBarItem(
                      item: _items[index],
                      isSelected: controller.currentIndex == index,
                      onTap: () {
                        if (controller.currentIndex != index) {
                          HapticFeedback.lightImpact();
                          controller.onPageChanged(index);
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.labelKey,
    required this.outlinedIcon,
    required this.filledIcon,
    required this.color,
  });

  final String labelKey;
  final IconData outlinedIcon;
  final IconData filledIcon;
  final Color color;
}

class _NavBarItem extends StatefulWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final _NavItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.isSelected;
    final itemColor = widget.item.color;
    final color = selected ? itemColor : itemColor.withOpacity(0.45);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(vertical: 6.h),
          decoration: BoxDecoration(
            color: selected ? itemColor.withOpacity(0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                width: selected ? 44.w : 36.w,
                height: selected ? 30.h : 28.h,
                decoration: BoxDecoration(
                  color: selected
                      ? itemColor.withOpacity(0.18)
                      : itemColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  selected ? widget.item.filledIcon : widget.item.outlinedIcon,
                  size: selected ? 22.sp : 21.sp,
                  color: color,
                ),
              ),
              SizedBox(height: 4.h),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                style: TextStyle(
                  fontSize: selected ? 11.5.sp : 11.sp,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                  fontFamily: 'Cairo',
                  height: 1.1,
                ),
                child: Text(widget.item.labelKey.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
