import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/inject/inject.dart';
import 'package:dash_receitas/src/core/routes/service_modules.dart';
import 'package:dash_receitas/src/core/themes/custom_theme.dart';
import 'package:dash_receitas/src/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';

void main() {
  Inject.inicialize();
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  ServiceModules().register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeService _themeController = di();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_themeController]),
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Receitinhas',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeController.chooseTheme,
          routerConfig: ServiceModules().routers,
        );
      },
    );
  }
}
