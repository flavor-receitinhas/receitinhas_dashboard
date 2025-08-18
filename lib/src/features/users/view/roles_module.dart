import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/users/controllers/role_controller.dart';
import 'package:dash_receitas/src/features/users/domain/services/roles_service.dart';
import 'package:go_router/go_router.dart';

class RolesModule implements RegisterModule {
  @override
  void inicialize() {
    //Services
    di.registerLazySingleton(() => RolesService());
    //Controller
    di.registerLazySingleton<RoleController>(() => RoleController(di()));
  }

  @override
  List<RouteBase> routes() {
    return [];
  }
}
