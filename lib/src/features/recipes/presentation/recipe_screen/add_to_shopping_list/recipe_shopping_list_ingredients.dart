import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/common_widgets/async_value_widget.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/add_to_shopping_list/add_to_shopping_list_controller.dart';
import 'package:my_recipes/src/features/shopping_list/application/shopping_list_service.dart';

class RecipeShoppingListIngredients extends ConsumerWidget {
  const RecipeShoppingListIngredients({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recList = ref.watch(shoppingRecipeWatchProvider(recipe.id));
    debugPrint("Render");

    return AsyncValueWidget(
      value: recList,
      data: (list) {
        return ListView.builder(
          itemCount: recipe.ingredients.length,
          itemBuilder: (context, index) {
            final isAdded = list.ingredients.any((element) =>
                element.ingredientName == recipe.ingredients[index].name);

            return CheckboxListTile(
              value: isAdded,
              title: Text(recipe.ingredients[index].name),
              onChanged: (value) => isAdded
                  ? ref
                      .read(recipeShoppingListControllerProvider.notifier)
                      .deleteIngredient(
                        ingredientName: recipe.ingredients[index].name,
                        recipeId: recipe.id,
                      )
                  : ref
                      .read(recipeShoppingListControllerProvider.notifier)
                      .addIngredient(
                        ingredientName: recipe.ingredients[index].name,
                        recipeId: recipe.id,
                        recipeName: recipe.name,
                      ),
            );
          },
        );
      },
    );
  }
}
