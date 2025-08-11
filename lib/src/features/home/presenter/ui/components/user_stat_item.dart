import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:flutter/material.dart';

class UserStatItem extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final ThemeData theme;

  const UserStatItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: CookieText(
            text: label,
            typography: CookieTypography.tiny,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        CookieText(
          text: value.toString(),
          typography: CookieTypography.body,
          color: theme.colorScheme.onSurface,
        ),
      ],
    );
  }
}
