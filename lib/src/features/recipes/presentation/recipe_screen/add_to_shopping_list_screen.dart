import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/common_widgets/async_value_widget.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/add_to_shopping_list/add_to_shopping_list_controller.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/add_to_shopping_list/recipe_shopping_list_ingredients.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';
import 'package:my_recipes/src/utils/async_value_ui.dart';

class AddToShoppingListScreen extends ConsumerWidget {
  const AddToShoppingListScreen({
    super.key,
    required this.recipeId,
  });
  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Show an alert if updating the shopping list fails
    ref.listen(
      recipeShoppingListControllerProvider,
      (previous, state) {
        state.showAlertDialogOnError(context);
      },
    );

    // final controllerRecipe = ref.watch(recipeControllerProvider(recipeId));
    // final controllerRecipe = ref.watch(addToCartProvider(recipeId));
    // final controllerRecipe = ref.watch(testControllerProvider2(recipeId));

    // final controllerRecipe = ref.watch(addableIngredientProvider(recipeId));
    final rec = ref.watch(testProvider3(recipeId));

    return Scaffold(
      appBar: AppBar(
        title: Text("Add to shopping list".hardcoded),
      ),
      body: AsyncValueWidget(
        value: rec.recipe,
        data: (recipe) {
          return RecipeShoppingListIngredients(
            recipe: recipe,
          );
          // return ListView.builder(
          //   itemCount: recipe.ingredients.length,
          //   itemBuilder: (context, index) {
          //     // final isChecked = ref
          //     //     .read(addableIngredientProvider(recipeId).notifier)
          //     //     .isAdded(
          //     //       recipe.ingredients[index].name,
          //     //     );

          //     final isAdded =
          //         ref.read(testProvider3(recipeId).notifier).isAdded(
          //               recipe.ingredients[index].name,
          //             );

          //     return CheckboxListTile(
          //       value: isAdded,
          //       title: Text(recipe.ingredients[index].name),
          //       onChanged: (value) => ref
          //           .read(recipeShoppingListControllerProvider.notifier)
          //           .addIngredient(
          //             // value,
          //             recipe.ingredients[index].name,
          //             recipeId,
          //           ),
          //     );

          // final isChecked = ref
          //     .read(addableIngredientProvider(recipeId).notifier)
          //     .isAdded(
          //       recipe[index].name,
          //     );

          // return CheckboxListTile(
          //   value: isChecked,
          //   title: Text(recipe[index].name),
          //   onChanged: (value) => ref
          //       .read(recipeShoppingListControllerProvider.notifier)
          //       .toggle(
          //         value,
          //         recipe[index].name,
          //         recipeId,
          //       ),
          // );
        },
      ),
    );
  }
}
