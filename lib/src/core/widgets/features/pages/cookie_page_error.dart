import 'package:dash_receitas/src/core/widgets/features/cookie_button.dart';
import 'package:dash_receitas/src/core/widgets/features/cookie_text.dart';
import 'package:flutter/material.dart';

class CookiePageError extends StatelessWidget {
  final String errorMessage;
  final void Function() onReload;
  const CookiePageError({
    super.key,
    required this.errorMessage,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Spacer(),
              // Image.asset('', height: MediaQuery.sizeOf(context).height * 0.33),
              const SizedBox(height: 10),
              CookieText(text: errorMessage),
              const SizedBox(height: 10),
              CookieButton(label: 'Recarregar', onPressed: onReload),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
