import 'package:dash_receitas/src/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/widgets.dart';

class UsersController extends ChangeNotifier {
  List<UserEntity> users = [];

  Future<void> init() async {
    users = [
      UserEntity(id: '1', email: 'ana.silva@email.com'),
      UserEntity(id: '1', email: 'mathias.silva@email.com'),
    ];
  }

  Future<void> searchUsers(String searchTerm) async {
    users = users.where((user) {
      return user.email.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
    notifyListeners();
  }
}
