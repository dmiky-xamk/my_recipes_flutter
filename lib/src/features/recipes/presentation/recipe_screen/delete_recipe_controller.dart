import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/recipes/data/recipes_repository.dart';

/// Handles calling the [RecipesRepository] to delete a recipe
/// Helps to show dialog errors to the user if the recipe cannot be deleted
class DeleteRecipeController extends StateNotifier<AsyncValue<void>> {
  DeleteRecipeController({required this.recipesRepository})
      : super(const AsyncData(null));
  final RecipesRepository recipesRepository;

  Future<bool> deleteRecipe(String id) async {
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
        () => recipesRepository.deleteRecipe(recipeId: id));

    state = value;

    return !value.hasError;
  }
}

final deleteRecipeControllerProvider =
    StateNotifierProvider.autoDispose<DeleteRecipeController, AsyncValue<void>>(
  (ref) {
    return DeleteRecipeController(
        recipesRepository: ref.watch(recipesRepositoryProvider));
  },
);
