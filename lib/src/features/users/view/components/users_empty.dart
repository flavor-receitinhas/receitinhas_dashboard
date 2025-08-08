import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:flutter/material.dart';

class UsersEmptyComponent extends StatelessWidget {
  const UsersEmptyComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            CookieText(
              text: 'Nenhum usuário encontrado',
              typography: CookieTypography.title,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            CookieText(
              text: 'Tente ajustar os filtros de busca',
              typography: CookieTypography.body,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}
