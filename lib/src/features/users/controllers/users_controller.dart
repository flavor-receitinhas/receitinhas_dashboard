import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/features/users/domain/entity/users_entity.dart';
import 'package:dash_receitas/src/features/users/domain/services/users_services.dart';
import 'package:flutter/widgets.dart';

class UsersController extends ChangeNotifier {
  final _service = di<UsersServices>();
  List<UsersEntity> _allUsers = [];
  List<UsersEntity> users = [];

  Future<void> init() async {
    users = await _service.listUsers();
    notifyListeners();
  }

  Future<void> getAllUsers() async {
    _allUsers = await _service.listUsers();
    users = List.from(_allUsers);
    notifyListeners();
  }

  Future<void> disableUser(int index) async {
    await _service.disableUser(users[index].id);
    users[index].disabled = true;
    notifyListeners();
  }

  Future<void> activeUser(int index) async {
    await _service.enableUser(users[index].id);
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
}
