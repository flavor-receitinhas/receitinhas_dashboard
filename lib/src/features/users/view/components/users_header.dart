import 'package:dash_receitas/src/core/global/assets_enum.dart';
import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:flutter/material.dart';

class DefaultPageHeaderComponent extends StatelessWidget {
  final String title;
  final String description;
  final List<dynamic> data;
  final String typeOfData;

  const DefaultPageHeaderComponent({
    super.key,
    required this.data,
    required this.title,
    required this.description,
    required this.typeOfData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow.shade800, Colors.yellow.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: CookieSvg(
              svg: IconsSvgEnum.persons,
              color: Colors.white,
              height: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CookieText(
                  text: title,
                  typography: CookieTypography.title,
                  color: Colors.white,
                ),
                const SizedBox(height: 4),
                CookieText(
                  text: description,
                  typography: CookieTypography.body,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CookieText(
              text: '${data.length} $typeOfData',
              typography: CookieTypography.button,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
