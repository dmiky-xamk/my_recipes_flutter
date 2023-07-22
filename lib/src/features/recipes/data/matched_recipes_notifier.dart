// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_recipes/src/constants/test_recipes.dart';
// import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';
// import 'package:my_recipes/src/features/recipes/domain/recipe.dart';

// @immutable
// class MatchedRecipe {
//   const MatchedRecipe({
//     required this.recipe,
//     required this.matchingIngredients,
//     required this.nonMatchingIngredients,
//     required this.totalIngredientsCount,
//   });

//   final Recipe recipe;
//   final Iterable<Ingredient> matchingIngredients;
//   final Iterable<Ingredient> nonMatchingIngredients;
//   final int totalIngredientsCount;
// }

// class MatchedRecipesNotifier extends StateNotifier<Iterable<MatchedRecipe>> {
//   MatchedRecipesNotifier(this.recipes) : super([]);
//   final List<Recipe> recipes;

//   void updateMatchedRecipes(
//     Iterable<String> ingredientNames,
//   ) {
//     debugPrint("Updating matched recipes...");
//     debugPrint("Ingredient names: $ingredientNames");
//     // debugPrint("Recipes: $recipes");
//     // final recipes = kTestRecipes;
//     final matchedRecipes = recipes.map(
//       (recipe) {
//         List<Ingredient> matchingIngredients = [];
//         List<Ingredient> nonMatchingIngredients = [];

//         for (var ingredient in recipe.ingredients) {
//           if (ingredientNames.contains(ingredient.name)) {
//             matchingIngredients.add(ingredient);
//           } else {
//             nonMatchingIngredients.add(ingredient);
//           }
//         }
//         return MatchedRecipe(
//           recipe: recipe,
//           matchingIngredients: matchingIngredients,
//           nonMatchingIngredients: nonMatchingIngredients,
//           totalIngredientsCount: recipe.ingredients.length,
//         );
//       },
//     ).where((match) => match.matchingIngredients.isNotEmpty);

//     state = [...matchedRecipes];

//     for (var element in matchedRecipes) {
//       debugPrint("Found recipe: ${element.recipe.name}");
//     }
//   }
// }

// final matchedRecipesProvider = StateNotifierProvider.autoDispose<
//     MatchedRecipesNotifier,
//     Iterable<MatchedRecipe>>((ref) => MatchedRecipesNotifier(kTestRecipes));

// final matchedRecipesProviderFamily = StateNotifierProvider.autoDispose
//     .family<MatchedRecipesNotifier, Iterable<MatchedRecipe>, List<Recipe>>(
//         (ref, recipes) => MatchedRecipesNotifier(recipes));
