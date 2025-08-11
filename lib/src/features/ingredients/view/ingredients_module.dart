import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/ingredients/controllers/ingredients_controller.dart';
import 'package:dash_receitas/src/features/ingredients/view/pages/ingredients_page.dart';
import 'package:domain_receitinhas/request_receitinhas.dart';
import 'package:go_router/go_router.dart';

class IngredientsModule implements RegisterModule {
  @override
  void inicialize() {
    //Repository
    di.registerLazySingleton<IngredientRepository>(
      () => IngredientRepositoryImp(),
    );
    //Controller
    di.registerLazySingleton(() => IngredientsController(di()));
  }

  @override
  List<RouteBase> routes() {
    return [
      GoRoute(
        path: IngredientsPage.route,
        builder: (context, state) {
          return const IngredientsPage();
        },
      ),
    ];
  }
}
