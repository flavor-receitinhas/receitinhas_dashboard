import 'package:domain_receitinhas/features/users/domain/entities/user_entity.dart';
import 'package:domain_receitinhas/features/users/repositories/users_repository.dart';
import 'package:flutter/widgets.dart';

import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/features/users/domain/entity/roles_enum.dart';
import 'package:dash_receitas/src/features/users/domain/services/roles_service.dart';

class UsersController extends ChangeNotifier {
  final UsersRepository _repo;
  final _roleService = di<RolesService>();

  UsersController(this._repo);

  List<UsersEntity> _allUsers = [];
  List<UsersEntity> users = [];

  Future<void> init() async {
    users = await _repo.listUsers();
    notifyListeners();
  }

  Future<void> getAllUsers() async {
    _allUsers = await _repo.listUsers();
    users = List.from(_allUsers);
    notifyListeners();
  }

  Future<void> disableUser(int index) async {
    await _repo.disableUser(users[index].id);
    users[index].disabled = true;
    notifyListeners();
  }

  Future<void> activeUser(int index) async {
    await _repo.enableUser(users[index].id);
    users[index].disabled = false;
    notifyListeners();
  }

  Future<void> searchUsers(String searchTerm) async {
    users = users.where((user) {
      return user.email.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
    notifyListeners();
  }

  Future<void> clearSearch() async {
    users = List.from(_allUsers);
    notifyListeners();
  }

  String formatUserDateTime(String dateTime) {
    final date = DateTime.parse(dateTime);
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> editRole(String userId, RoleEntity role, int index) async {
    await _roleService.updateRole(role);
    users[index].role = role.role.name;
    notifyListeners();
  }
}
