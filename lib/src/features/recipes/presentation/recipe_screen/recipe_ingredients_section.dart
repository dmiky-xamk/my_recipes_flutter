import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';
import 'package:my_recipes/src/routing/app_router.dart';

class RecipeIngredientsSection extends StatelessWidget {
  const RecipeIngredientsSection(
      {super.key, required this.recipeId, required this.ingredients});

  final String recipeId;
  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Ingredients".hardcoded,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            IconButton(
              icon: const Icon(
                Icons.add_shopping_cart,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => context.pushNamed(
                AppRoute.addRecipeToCart.name,
                params: {
                  "id": recipeId,
                },
              ),
            )
          ],
        ),
        gapH8,
        for (var ingredient in ingredients)
          Text(
            "${ingredient.amount} ${ingredient.unit} ${ingredient.name}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
      ],
    );
  }
}
