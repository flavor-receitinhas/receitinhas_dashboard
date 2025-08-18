import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/home/presenter/controller/home_controller.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/pages/home_page.dart';
import 'package:dash_receitas/src/features/users/domain/entity/roles_enum.dart';
import 'package:dash_receitas/src/features/users/domain/services/roles_service.dart';
import 'package:go_router/go_router.dart';

class HomeModule extends RegisterModule {
  @override
  void inicialize() {
    di.registerLazySingleton<HomeController>(() => HomeController(di(), di()));

    RolesService().verifyUserPermission().then((value) {
      Global.isAdmin = value.role.name == Roles.admin.name;
      Global.role = value.role;
    });
  }

  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: HomePage.route,
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ];
  }
}
