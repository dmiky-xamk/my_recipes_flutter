// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';

@immutable
class MatchedRecipe {
  const MatchedRecipe({
    required this.recipe,
    required this.matchingIngredients,
    required this.nonMatchingIngredients,
    required this.totalIngredientsCount,
  });

  final Recipe recipe;
  final Iterable<Ingredient> matchingIngredients;
  final Iterable<Ingredient> nonMatchingIngredients;
  final int totalIngredientsCount;
}

class MatchedRecipesNotifier extends StateNotifier<List<MatchedRecipe>> {
  MatchedRecipesNotifier() : super([]);

  void updateMatchedRecipes(
    List<Recipe> recipes,
    Iterable<String> ingredientNames,
  ) {
    final matchedRecipes = recipes.map(
      (recipe) {
        List<Ingredient> matchingIngredients = [];
        List<Ingredient> nonMatchingIngredients = [];

        for (final ingredient in recipe.ingredients) {
          if (ingredientNames.contains(ingredient.name)) {
            matchingIngredients.add(ingredient);
          } else {
            nonMatchingIngredients.add(ingredient);
          }
        }

        return MatchedRecipe(
          recipe: recipe,
          matchingIngredients: matchingIngredients,
          nonMatchingIngredients: nonMatchingIngredients,
          totalIngredientsCount: recipe.ingredients.length,
        );
      },
    ).where((match) => match.matchingIngredients.isNotEmpty);

    state = [
      ...matchedRecipes.sorted(
        (a, b) {
          // Sort by number of matched ingredients
          if (b.matchingIngredients.length
                  .compareTo(a.matchingIngredients.length) !=
              0) {
            return b.matchingIngredients.length
                .compareTo(a.matchingIngredients.length);
          }
          // If number of matched ingredients are equal, sort by number of missing ingredients
          if (a.nonMatchingIngredients.length
                  .compareTo(b.nonMatchingIngredients.length) !=
              0) {
            return a.nonMatchingIngredients.length
                .compareTo(b.nonMatchingIngredients.length);
          }
          // If number of missing ingredients are also equal, sort alphabetically by recipe name
          return a.recipe.name.compareTo(b.recipe.name);
        },
      )
    ];

    for (var element in matchedRecipes) {
      debugPrint("Found recipe: ${element.recipe.name}");
    }
  }
}

final matchedRecipesControllerProvider = StateNotifierProvider.autoDispose<
    MatchedRecipesNotifier, List<MatchedRecipe>>((ref) {
  return MatchedRecipesNotifier();
});
