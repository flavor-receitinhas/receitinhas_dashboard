import 'package:dash_receitas/src/features/users/domain/entity/roles_enum.dart';
import 'package:domain_receitinhas/core/api/api_recipes.dart';

class RolesService {
  final _api = ApiRecipes();

  Future<RoleEntity> verifyUserPermission() async {
    final response = await _api.get(path: '/role/me') as Map<String, dynamic>;
    return RoleEntity.fromMap(response);
  }

  Future<void> updateRole(RoleEntity role) async {
    await _api.put(
      path: '/role/user',
      body: {'userId': role.userId, 'type': role.role.name},
    );
  }
}
