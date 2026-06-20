import 'package:flutter/material.dart';
import 'package:mybeshop/core/utils/currency/riyal_formatter.dart';

/// Displays a price with the official Saudi Riyal symbol when applicable.
class RiyalPriceText extends StatelessWidget {
  const RiyalPriceText({
    super.key,
    required this.amount,
    this.currency,
    this.style,
    this.formatted = false,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  /// Raw amount (e.g. `75.00`) or pre-formatted string when [formatted] is true.
  final String amount;
  final String? currency;
  final TextStyle? style;
  final bool formatted;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final display = formatted
        ? _formatPreFormatted(amount)
        : RiyalFormatter.format(
            amount: amount,
            currency: currency ?? 'SAR',
          );

    if (!display.contains(RiyalFormatter.symbol)) {
      return Text(
        display,
        style: style,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        textDirection: TextDirection.ltr,
      );
    }

    return Text.rich(
      RiyalFormatter.buildPriceSpan(display, style),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textDirection: TextDirection.ltr,
    );
  }

  static String _formatPreFormatted(String amount) {
    final normalized = RiyalFormatter.normalizeFormatted(amount);
    if (RiyalFormatter.containsSaudiSymbol(normalized)) {
      return normalized;
    }
    if (RegExp(r'^[\d.,]+$').hasMatch(normalized)) {
      return RiyalFormatter.format(amount: normalized, currency: 'SAR');
    }
    return normalized;
  }
}
