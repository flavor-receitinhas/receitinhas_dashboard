import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:domain_receitinhas/features/recipes/domain/dtos/recipe_dto.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final List<RecipeDto> recentRecipes;
  final ThemeData theme;

  const RecipeCard({
    super.key,
    required this.recentRecipes,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.restaurant, color: Colors.orange),
              const SizedBox(width: 8),
              CookieText(
                text: 'Receitas Recentes',
                typography: CookieTypography.button,
                color: theme.colorScheme.onSurface,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (recentRecipes.isEmpty)
            Center(
              child: CookieText(
                text: 'Nenhuma receita encontrada',
                typography: CookieTypography.body,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            )
          else
            ...recentRecipes.map(
              (recipe) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: recipe.thumb != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                recipe.thumb!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.restaurant,
                                      color: Colors.orange,
                                    ),
                              ),
                            )
                          : Icon(Icons.restaurant, color: Colors.orange),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CookieText(
                            text: recipe.title,
                            typography: CookieTypography.body,
                            color: theme.colorScheme.onSurface,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          CookieText(
                            text: '${recipe.timePrepared} min',
                            typography: CookieTypography.tiny,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
