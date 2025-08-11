import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_default_page.dart';
import 'package:dash_receitas/src/features/ingredients/view/components/custom_pop_menu.dart';
import 'package:dash_receitas/src/features/recipes/controllers/recipes_controller.dart';
import 'package:flutter/material.dart';

class RecipesPage extends StatefulWidget {
  static const String route = '/recipes';
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final ct = di<RecipesController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ct.init();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CookieDefaultPage(
      currentRoute: RecipesPage.route,
      popMenu: (i) => CustomPopupMenu(
        onDelete: () async {
          await ct.deleteRecipe(i);
          setState(() {});
        },
      ),
      data: ct.recipes
          .map(
            (e) => DefaultPageEntity(
              title: e.title,
              data: [e],
              description: e.recipeId,
            ),
          )
          .toList(),
      pageTitle: 'Receitas',
      onSearch: (s) {
        if (s.isEmpty) {
          ct.clearSearch();
          setState(() {});
          return;
        }
        ct.searchRecipes(s);
        setState(() {});
      },
      headerTitle: 'Receitas',
      headerDescription: 'Gerencie as receitas da plataforma.',
    );
  }
}
