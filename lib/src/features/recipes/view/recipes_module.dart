import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/recipes/controllers/recipes_controller.dart';
import 'package:dash_receitas/src/features/recipes/view/pages/recipes_page.dart';
import 'package:domain_receitinhas/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:domain_receitinhas/features/recipes/domain/repositories/recipe_repository_imp.dart';
import 'package:go_router/go_router.dart';

class RecipesModule implements RegisterModule {
  @override
  void inicialize() {
    di.registerLazySingleton<RecipeRepository>(
      () => RecipeRepositoryImp(),
    );
    di.registerLazySingleton(() => RecipesController(di()));
  }

  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: RecipesPage.route,
        builder: (context, state) {
          return const RecipesPage();
        },
      ),
    ];
  }
}
