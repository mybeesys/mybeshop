import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mybeshop/core/theme/app_styles.dart';
import 'package:mybeshop/core/theme/app_theme.dart';

class CartQuantityStepper extends StatelessWidget {
  const CartQuantityStepper({
    super.key,
    required this.qty,
    required this.onDecrease,
    required this.onIncrease,
    this.enabled = true,
    this.compact = false,
  });

  final int qty;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  final bool enabled;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final buttonSize = compact ? 32.w : 36.w;
    final iconSize = compact ? 14.sp : 16.sp;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.to.backgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppTheme.to.borderColor),
      ),
      padding: EdgeInsets.all(compact ? 3.w : 4.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            size: buttonSize,
            icon: LineAwesomeIcons.minus,
            iconSize: iconSize,
            onTap: enabled ? onDecrease : null,
          ),
          SizedBox(
            width: compact ? 28.w : 32.w,
            child: Text(
              '$qty',
              style: AppStyles.bodyBoldM,
              textAlign: TextAlign.center,
            ),
          ),
          _StepperButton(
            size: buttonSize,
            icon: LineAwesomeIcons.plus,
            iconSize: iconSize,
            onTap: enabled ? onIncrease : null,
            filled: true,
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.size,
    required this.icon,
    required this.iconSize,
    this.onTap,
    this.filled = false,
  });

  final double size;
  final IconData icon;
  final double iconSize;
  final VoidCallback? onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: filled
                ? (disabled
                    ? AppTheme.to.primaryColor.withOpacity(0.35)
                    : AppTheme.to.primaryColor)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: iconSize,
            color: filled
                ? AppTheme.to.onPrimaryColor
                : (disabled
                    ? AppTheme.to.greyColor.withOpacity(0.4)
                    : AppTheme.to.textColor),
          ),
        ),
      ),
    );
  }
}
