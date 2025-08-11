import 'package:domain_receitinhas/features/recipes/domain/entities/ingredient_entity.dart';
import 'package:domain_receitinhas/features/recipes/domain/repositories/ingredient_repository.dart';
import 'package:flutter/widgets.dart';

class IngredientsController extends ChangeNotifier {
  List<IngredientEntity> _allIngredients = [];
  List<IngredientEntity> ingredients = [];

  final IngredientRepository _service;
  IngredientsController(this._service);

  Future<void> init() async {
    await listIngredients();
  }

  Future<List<IngredientEntity>> listIngredients() async {
    final ingredientsData = await _service.listIngredient();
    _allIngredients = List.unmodifiable(ingredientsData);
    ingredients = List.from(_allIngredients);
    notifyListeners();
    return ingredientsData;
  }

  Future<void> searchIngredients(String searchTerm) async {
    ingredients = _allIngredients.where((ingredient) {
      return ingredient.name.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
    notifyListeners();
  }

  Future<void> clearSearch() async {
    ingredients = List.from(_allIngredients);
    notifyListeners();
  }
}
