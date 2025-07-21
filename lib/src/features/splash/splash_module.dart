import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/splash/presenter/controller/splash_controller.dart';
import 'package:dash_receitas/src/features/splash/presenter/ui/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

class SplashModule extends RegisterModule {
  @override
  void inicialize() {
    //controller
    di.registerFactory<SplashController>(() => SplashController());
  }

  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: SplashPage.route,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
    ];
  }
}
