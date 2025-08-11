import 'package:dash_receitas/src/features/users/domain/entity/users_entity.dart';
import 'package:dash_receitas/src/features/users/domain/services/users_services.dart';
import 'package:domain_receitinhas/request_receitinhas.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final UsersServices _usersServices;
  final RecipeRepository _recipesRepo;
  HomeController(this._usersServices, this._recipesRepo);

  List<UsersEntity> users = [];
  List<RecipeDto> recipes = [];

  Future<void> init() async {
    await getUsers();
    await getRecipes();
    notifyListeners();
  }

  Future<void> getUsers() async {
    users = await _usersServices.listUsers();
    notifyListeners();
  }

  Future<void> getRecipes() async {
    recipes = await _recipesRepo.listRecipe(page: 0);
    notifyListeners();
  }
}
