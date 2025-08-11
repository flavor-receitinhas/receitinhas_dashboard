import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:flutter/material.dart';

class ProviderStatItem extends StatelessWidget {
  final String provider;
  final int count;
  final ThemeData theme;

  const ProviderStatItem({
    super.key,
    required this.provider,
    required this.count,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          CookieText(
            text: provider,
            typography: CookieTypography.tiny,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          const Spacer(),
          CookieText(
            text: count.toString(),
            typography: CookieTypography.tiny,
            color: theme.colorScheme.onSurface,
          ),
        ],
      ),
    );
  }
}
