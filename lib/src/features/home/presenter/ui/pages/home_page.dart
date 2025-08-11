import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_dash_template.dart';
import 'package:dash_receitas/src/features/home/presenter/controller/home_controller.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/components/home_cards.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/components/recipe_card.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/components/user_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController ct = di<HomeController>();

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
    final users = ct.users;
    final recipes = ct.recipes;
    final theme = Theme.of(context);

    return DashboardTemplate(
      title: 'Home',
      currentRoute: HomePage.route,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CookieText(
              text: 'Dashboard Principal',
              typography: CookieTypography.title,
            ),
            const SizedBox(height: 8),
            CookieText(
              text: 'Bem-vindo ao painel de controle!',
              typography: CookieTypography.body,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: HomeCards(
                    title: 'Total de Usuários',
                    value: users.length.toString(),
                    icon: Icons.people_outline,
                    color: Colors.blue,
                    theme: theme,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: HomeCards(
                    title: 'Total de Receitas',
                    value: recipes.length.toString(),
                    icon: Icons.restaurant_menu_outlined,
                    color: Colors.orange,
                    theme: theme,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: HomeCards(
                    title: 'Usuários Ativos',
                    value: users.where((u) => !u.disabled).length.toString(),
                    icon: Icons.verified_user_outlined,
                    color: Colors.green,
                    theme: theme,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: HomeCards(
                    title: 'Tempo Médio',
                    value: _getAverageTime(),
                    icon: Icons.timer_outlined,
                    color: Colors.purple,
                    theme: theme,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: RecipeCard(recentRecipes: ct.recipes, theme: theme),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: UserCard(
                    activeUsers: users.where((u) => !u.disabled).length,
                    inactiveUsers: users.where((u) => u.disabled).length,
                    emailVerifiedUsers: users
                        .where((u) => u.emailVerified)
                        .length,
                    theme: theme,
                    users: users,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getAverageTime() {
    if (ct.recipes.isEmpty) return '0 min';
    final totalTime = ct.recipes.fold<int>(
      0,
      (sum, recipe) => sum + recipe.timePrepared,
    );
    final average = totalTime ~/ ct.recipes.length;
    return '$average min';
  }
}
