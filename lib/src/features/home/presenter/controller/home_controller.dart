import 'package:domain_receitinhas/features/recipes/domain/dtos/recipe_dto.dart';
import 'package:domain_receitinhas/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:domain_receitinhas/features/users/domain/entities/user_entity.dart';
import 'package:domain_receitinhas/features/users/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  final UsersRepository _usersRepo;
  final RecipeRepository _recipesRepo;
  HomeController(this._usersRepo, this._recipesRepo);

  List<UsersEntity> users = [];
  List<RecipeDto> recipes = [];

  Future<void> init() async {
    await getUsers();
    await getRecipes();
    notifyListeners();
  }

  Future<void> getUsers() async {
    users = await _usersRepo.listUsers();
    notifyListeners();
  }

  Future<void> getRecipes() async {
    recipes = await _recipesRepo.listRecipe(page: 0);
    notifyListeners();
  }
}
