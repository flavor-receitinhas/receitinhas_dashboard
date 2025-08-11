import 'package:domain_receitinhas/request_receitinhas.dart';
import 'package:flutter/material.dart';

class RecipesController extends ChangeNotifier {
  List<RecipeDto> _allRecipes = [];
  List<RecipeDto> recipes = [];
  final RecipeRepository _recipesRepository;

  RecipesController(this._recipesRepository);

  Future<void> init() async {
    await listRecipes();
    notifyListeners();
  }

  Future<List<RecipeDto>> listRecipes() async {
    final response = await _recipesRepository.listRecipe(page: 0);
    _allRecipes = List.unmodifiable(response);
    recipes = List.from(_allRecipes);
    return recipes;
  }


  Future<void> searchRecipes(String searchTerm) async {
    recipes = _allRecipes.where((recipe) {
      return recipe.title.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
  }

  Future<void> deleteRecipe(int index) async {
    await _recipesRepository.deleteRecipe(recipes[index].recipeId);
    recipes.removeAt(index);
    notifyListeners();
  }

  Future<void> clearSearch() async {
    recipes = List.from(_allRecipes);
  }
}
