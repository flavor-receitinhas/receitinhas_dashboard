import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/features/ingredients/controllers/ingredients_controller.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_default_page.dart';
import 'package:flutter/material.dart';

class IngredientsPage extends StatefulWidget {
  static const String route = '/ingredients';
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<IngredientsPage> {
  final ct = di<IngredientsController>();
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
    final ingredient = ct.ingredients;
    return CookieDefaultPage(
      onSearch: (s) {
        if (s.isEmpty) {
          ct.clearSearch();
          setState(() {});
          return;
        }
        ct.searchIngredients(s);
        setState(() {});
      },
      headerTitle: 'Ingredientes',
      headerDescription: 'Gerencie os ingredientes da plataforma.',
      currentRoute: IngredientsPage.route,
      searchHint: 'Buscar ingredientes...',
      data: ingredient
          .map(
            (e) => DefaultPageEntity(
              title: e.name,
              data: [e],
              description: (e.description!.isEmpty ? e.id : e.description),
            ),
          )
          .toList(),
      pageTitle: 'Ingredientes',
    );
  }
}
