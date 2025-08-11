import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/services/api/api_recipes.dart';
import 'package:dash_receitas/src/features/users/domain/entity/users_entity.dart';

class UsersServices {
  final _api = di<ApiRecipes>();

  Future<List<UsersEntity>> listUsers() async {
    final response = await _api.get(path: '/user') as List;

    return response
        .map((e) => UsersEntity.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> disableUser(String id) async {
    await _api.post(path: '/user/disable/$id');
  }

  Future<void> enableUser(String id) async {
    await _api.post(path: '/user/enable/$id');
  }
}
