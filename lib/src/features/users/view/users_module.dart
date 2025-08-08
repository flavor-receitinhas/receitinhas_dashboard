import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/users/controllers/users_controller.dart';
import 'package:dash_receitas/src/features/users/view/users_page.dart';
import 'package:go_router/go_router.dart';

class UsersModule implements RegisterModule {
  @override
  void inicialize() {
    di.registerLazySingleton(() => UsersController());
  }

  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: UsersPage.route,
        builder: (context, state) {
          return const UsersPage();
        },
      ),
    ];
  }
}
