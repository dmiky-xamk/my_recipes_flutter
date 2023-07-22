import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/recipes/data/recipes_repository.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipes_list/recipes_list_controller.dart';

/// Handles modifying the state of a single recipe
/// and updating the state of the [RecipesListController] when a recipe is modified
class RecipeController extends StateNotifier<AsyncValue<Recipe>> {
  RecipeController(
      {required this.recipesRepository,
      required this.recipesController,
      required String id})
      : super(const AsyncLoading()) {
    _fetchRecipe(id);
  }
  final RecipesRepository recipesRepository;
  final RecipesListController recipesController;

  Future<void> _fetchRecipe(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => recipesRepository.fetchRecipe2(id),
    );
  }

  void updateState(Recipe recipe) {
    recipesController.updateState(recipe);
    state = AsyncData(recipe);
  }
}

final recipeControllerProvider = StateNotifierProvider.autoDispose
    .family<RecipeController, AsyncValue<Recipe>, String>(
  (ref, id) {
    final recipesRepository = ref.watch(recipesRepositoryProvider);
    final recipesController = ref.watch(recipesListControllerProvider.notifier);

    final link = ref.keepAlive();

    Timer? timer;

    ref.onDispose(
      () {
        timer?.cancel();
        debugPrint("Disposed");
      },
    );

    ref.onCancel(
      () {
        // * No need for the timer to run if the widget is not mounted
        // * Happens when the user deletes the recipe
        if (!ref.notifier.mounted) {
          return;
        }

        timer = Timer(
          const Duration(seconds: 30),
          () {
            debugPrint("Closed");
            link.close();
          },
        );
        debugPrint("Cancelled, starting timer...");
      },
    );

    ref.onResume(
      () {
        timer?.cancel();
        debugPrint("Resumed");
      },
    );

    return RecipeController(
      recipesRepository: recipesRepository,
      recipesController: recipesController,
      id: id,
    );
  },
);
