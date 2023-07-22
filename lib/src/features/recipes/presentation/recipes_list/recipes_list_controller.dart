// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_recipes/src/features/recipes/data/recipes_repository.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';

class RecipesListController extends StateNotifier<AsyncValue<List<Recipe>>> {
  RecipesListController({required this.recipesRepository})
      : super(const AsyncLoading()) {
    fetchRecipes();
  }
  final RecipesRepository recipesRepository;

  Future<void> fetchRecipes() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => recipesRepository.fetchRecipesList2());
  }

  void deleteRecipe(String id) {
    state.whenData(
      (recipes) {
        final index = recipes.indexWhere((element) => element.id == id);
        recipes.removeAt(index);
        state = AsyncData(recipes);
      },
    );
  }

  void updateState(Recipe recipe) {
    state.whenData(
      (recipes) {
        final index = recipes.indexWhere((element) => element.id == recipe.id);

        if (index == -1) {
          recipes.add(recipe);
        } else {
          recipes[index] = recipe;
        }
        state = AsyncData(recipes);
      },
    );
  }

  // If we update the state before fetching the recipes on the 'Recipes' screen
  // the provider will use the cached recipes instead of making another API call.
  void updateRecipesState(List<Recipe> recipes) {
    state = AsyncData(recipes);
  }
}

final recipesListControllerProvider =
    StateNotifierProvider<RecipesListController, AsyncValue<List<Recipe>>>(
  (ref) {
    final recipesRepository = ref.watch(recipesRepositoryProvider);

    ref.onDispose(() {
      debugPrint('disposing recipesListControllerProvider');
    });

    return RecipesListController(recipesRepository: recipesRepository);
  },
);
