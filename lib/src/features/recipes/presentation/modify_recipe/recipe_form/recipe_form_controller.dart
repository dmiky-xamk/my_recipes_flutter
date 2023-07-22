import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/recipes/data/recipes_repository.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_model.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_state.dart';

class RecipeFormController extends StateNotifier<RecipeFormState> {
  RecipeFormController({
    required this.recipesRepository,
    required RecipeFormType recipeFormType,
  }) : super(RecipeFormState(formType: recipeFormType));

  final RecipesRepository recipesRepository;

  Future<Recipe?> submit(RecipeFormModel recipe) async {
    debugPrint("RecipeFormController.submit() called");
    debugPrint(recipe.toString());

    state = state.copyWith(value: const AsyncLoading<void>());

    final value = await AsyncValue.guard(() => _submit(recipe));

    // final value = await AsyncValue.guard(
    //     () => Future<void>.delayed(const Duration(seconds: 1)));

    state = state.copyWith(value: value);

    return value.asData!.value;

    // return value.hasError == false;
  }

  Future<Recipe> _submit(RecipeFormModel recipe) async {
    switch (state.formType) {
      case RecipeFormType.create:
        return await recipesRepository.createRecipe(recipe: recipe);
      case RecipeFormType.edit:
        return await recipesRepository.updateRecipe(recipe: recipe);
      default:
        throw Exception("Unknown form type");
    }
  }
}

final recipeFormControllerProvider = StateNotifierProvider.autoDispose
    .family<RecipeFormController, RecipeFormState, RecipeFormType>(
        (ref, formType) {
  final recipesRepository = ref.watch(recipesRepositoryProvider);

  return RecipeFormController(
    recipesRepository: recipesRepository,
    recipeFormType: formType,
  );
});

// final createRecipeFormControllerProvider =
//     StateNotifierProvider.autoDispose<RecipeFormController, RecipeFormState>(
//         (ref) {
//   final recipesRepository = ref.watch(recipesRepositoryProvider);

//   return RecipeFormController(
//     recipesRepository: recipesRepository,
//     recipeFormType: RecipeFormType.create,
//   );
// });

// final editRecipeFormControllerProvider =
//     StateNotifierProvider.autoDispose<RecipeFormController, RecipeFormState>(
//         (ref) {
//   final recipesRepository = ref.watch(recipesRepositoryProvider);

//   return RecipeFormController(
//     recipesRepository: recipesRepository,
//     recipeFormType: RecipeFormType.edit,
//   );
// });
