import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/auth/domain/services/auth_serivce.dart';
import 'package:dash_receitas/src/features/auth/domain/services/auth_service_firebase.dart';
import 'package:dash_receitas/src/features/auth/presenter/controller/auth_controller.dart';
import 'package:dash_receitas/src/features/auth/presenter/ui/pages/login_page.dart';
import 'package:go_router/go_router.dart';

class AuthModule extends RegisterModule {
  @override
  void inicialize() {
    //Service
    di.registerLazySingleton<AuthService>(() => AuthServiceFirebase());

    // Registrar o controller de autenticação
    di.registerFactory<AuthController>(() => AuthController(di()));
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
