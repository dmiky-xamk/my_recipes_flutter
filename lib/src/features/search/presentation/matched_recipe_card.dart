import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/search/presentation/matched_recipe_card_ingredients.dart';
import 'package:my_recipes/src/features/search/presentation/matched_recipes_controller.dart';

class MatchedRecipeCard extends StatelessWidget {
  const MatchedRecipeCard({super.key, required this.recipe});

  final MatchedRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    recipe.recipe.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                gapW24,
                Text(
                    "${recipe.matchingIngredients.length} / ${recipe.totalIngredientsCount}"),
              ],
            ),
            gapH16,
            MatchedRecipeCardIngredients(
              ingredients: recipe.matchingIngredients,
            ),
            gapH8,
            Divider(color: Colors.grey[500]),
            gapH8,
            MatchedRecipeCardIngredients(
              ingredients: recipe.nonMatchingIngredients,
              secondary: true,
            ),
          ],
        ),
      ),
    );
  }
}
