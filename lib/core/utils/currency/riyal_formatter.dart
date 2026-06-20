import 'package:flutter/material.dart';

/// Saudi Riyal (SAR) formatting with the official symbol (Unicode U+20C1).
class RiyalFormatter {
  RiyalFormatter._();

  /// Official Saudi Riyal sign — rendered with [saudiRiyalFontFamily].
  static const String symbol = '\u{20C1}';

  static const String saudiRiyalFontFamily = 'SaudiRiyal';

  static final RegExp _sarCode = RegExp(r'\bSAR\b', caseSensitive: false);
  static final RegExp _srCode = RegExp(r'\bSR\b', caseSensitive: false);

  static bool isSaudiRiyal(String? currency) {
    if (currency == null || currency.trim().isEmpty) {
      return false;
    }
    final normalized = currency.trim().toUpperCase();
    return normalized == 'SAR' ||
        normalized == 'SR' ||
        normalized == 'ر.س' ||
        normalized == 'ريال' ||
        normalized == 'R.S' ||
        normalized.contains('SAUDI');
  }

  /// Builds a display string: `⃁ 75.00` for SAR, otherwise `75.00 USD`.
  static String format({
    required String amount,
    String? currency,
  }) {
    final value = amount.trim();
    if (isSaudiRiyal(currency)) {
      return '$symbol $value';
    }
    if (currency == null || currency.trim().isEmpty) {
      return value;
    }
    return '$value ${currency.trim()}';
  }

  /// Replaces SAR / ر.س in API pre-formatted strings (e.g. `75.00 SAR`).
  static String normalizeFormatted(String formatted) {
    var text = formatted.trim();
    if (text.isEmpty) {
      return text;
    }
    text = text.replaceAll(_sarCode, symbol);
    text = text.replaceAll(_srCode, symbol);
    text = text.replaceAll('ر.س', symbol);
    text = text.replaceAll('ريال', symbol);
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return text;
  }

  static TextStyle _symbolStyle(TextStyle? base) {
    return (base ?? const TextStyle()).copyWith(
      fontFamily: saudiRiyalFontFamily,
      fontFamilyFallback: base?.fontFamily != null
          ? [base!.fontFamily!]
          : const ['Cairo'],
    );
  }

  static TextSpan buildPriceSpan(String text, TextStyle? baseStyle) {
    if (!text.contains(symbol)) {
      return TextSpan(text: text, style: baseStyle);
    }
    final children = <InlineSpan>[];
    final parts = text.split(symbol);
    for (var i = 0; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        children.add(TextSpan(text: parts[i], style: baseStyle));
      }
      if (i < parts.length - 1) {
        children.add(TextSpan(text: symbol, style: _symbolStyle(baseStyle)));
      }
    }
    return TextSpan(children: children);
  }

  static bool containsSaudiSymbol(String text) {
    return text.contains(symbol) ||
        _sarCode.hasMatch(text) ||
        text.contains('ر.س') ||
        text.contains('ريال');
  }
}
