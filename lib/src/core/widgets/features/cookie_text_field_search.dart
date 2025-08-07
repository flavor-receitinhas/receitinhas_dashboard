import 'package:dash_receitas/src/core/global/assets_enum.dart';
import 'package:dash_receitas/src/core/widgets/features/cookie_svg.dart';
import 'package:flutter/material.dart';

class CookieTextFieldSearch extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function()? onEditingComplete;

  const CookieTextFieldSearch({
    super.key,
    this.hintText,
    this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onTap,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      validator: validator,
      onEditingComplete: onEditingComplete,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.85),
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSecondary.withValues(alpha: 0.5),
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: CookieSvg(
          svg: IconsSvgEnum.search,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
