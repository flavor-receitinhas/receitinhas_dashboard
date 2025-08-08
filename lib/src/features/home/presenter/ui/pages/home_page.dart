import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_dash_template.dart';
import 'package:flutter/material.dart';

// Páginas individuais do dashboard
class HomePage extends StatelessWidget {
  static const String route = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardTemplate(
      title: 'Home',
      currentRoute: HomePage.route,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CookieText(
              text: 'Dashboard Principal',
              typography: CookieTypography.title,
            ),
            const SizedBox(height: 16),
            CookieText(
              text: 'Bem-vindo ao painel de controle!',
              typography: CookieTypography.body,
            ),
          ],
        ),
      ),
    );
  }
}
