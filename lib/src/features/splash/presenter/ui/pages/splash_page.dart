import 'package:dash_receitas/src/core/global/assets_enum.dart';
import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/service_modules.dart';
import 'package:dash_receitas/src/core/widgets/features/cookie_text.dart';
import 'package:dash_receitas/src/features/auth/presenter/ui/pages/login_page.dart';
import 'package:dash_receitas/src/features/splash/presenter/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  static const route = '/splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController ct = di();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ct.init();
      ServiceModules.of.initialise().then((value) {
        if (mounted) {
          context.pushReplacement(
            ServiceModules.of.initalRoute ?? LoginPage.route,
          );
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                radius: 110,
                child: Image.asset(ImagesEnum.ovo.path, scale: 3),
              ),
            ),
            Spacer(),
            CookieText(
              text: 'Bem-vindo ao Dash Receitas',
              typography: CookieTypography.title,
              color: Theme.of(context).colorScheme.onPrimary,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
