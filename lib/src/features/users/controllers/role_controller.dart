import 'package:dash_receitas/src/features/users/domain/entity/roles_enum.dart';
import 'package:dash_receitas/src/features/users/domain/services/roles_service.dart';

class RoleController {
  final RolesService _rolesService;
  RoleController(this._rolesService);

  Future<void> init() async {
    await verifyUserPermission();
  }

  Future<bool> verifyUserPermission() async {
    final role = await _rolesService.verifyUserPermission();

    if (role.role.name == Roles.admin.name) {
      return true;
    } else {
      return false;
    }
  }
}
