import 'package:dash_receitas/src/core/global/state_manager.dart';
import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const String route = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CookiePage(
      state: StateManager.success,
      error: '',
      errorReload: () {},
      done: () {
        return SizedBox();
      },
    );
  }
}
