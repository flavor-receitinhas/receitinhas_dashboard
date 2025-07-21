import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/auth/presenter/ui/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class AuthModule extends RegisterModule {
  @override
  void inicialize() {
    //controller
  }

  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: LoginPage.route,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
    ];
  }
}
