import 'package:flutter/material.dart';

enum CookieTypography {
  title(16, true),
  button(14, true),
  body(14, false),
  tiny(12, false);

  final double size;
  final bool isBold;

  const CookieTypography(this.size, this.isBold);
}

class CookieText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final CookieTypography typography;
  final Color? color;
  final TextOverflow? overflow;
  final int? maxLine;
  final List<Shadow>? shadows;
  final bool isSelect;
  const CookieText({
    super.key,
    required this.text,
    this.typography = CookieTypography.body,
    this.color,
    this.textAlign,
    this.overflow,
    this.maxLine,
    this.shadows,
    this.isSelect = true,
  });

  @override
  Widget build(BuildContext context) {
    return isSelect
        ? SelectableText(
            text,
            textAlign: textAlign,
            // overflow: overflow,
            maxLines: maxLine,
            style: TextStyle(
              fontSize: typography.size,
              fontWeight: typography.isBold
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: color ?? Theme.of(context).colorScheme.onPrimary,
              shadows: shadows,
            ),
          )
        : Text(
            text,
            textAlign: textAlign,
            overflow: overflow,
            maxLines: maxLine,
            style: TextStyle(
              fontSize: typography.size,
              fontWeight: typography.isBold
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: color ?? Theme.of(context).colorScheme.onPrimary,
              shadows: shadows,
            ),
          );
  }
}
