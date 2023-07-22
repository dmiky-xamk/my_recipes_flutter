import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/common_widgets/alert_dialogs.dart';
import 'package:my_recipes/src/features/common_widgets/async_value_widget.dart';
import 'package:my_recipes/src/features/common_widgets/error_message_widget.dart';
import 'package:my_recipes/src/features/common_widgets/floating_snack_bar.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/delete_recipe_controller.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/recipe_controller.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/recipe_directions_section.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/recipe_ingredients_section.dart';
import 'package:my_recipes/src/routing/app_router.dart';
import 'package:my_recipes/src/utils/async_value_ui.dart';

import 'recipe_image_container.dart';

class RecipeScreen extends ConsumerWidget {
  const RecipeScreen({super.key, required this.recipeId});

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      deleteRecipeControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final controllerRecipe = ref.watch(recipeControllerProvider(recipeId));

    void deleteRecipe(String recipeId) async {
      final isSuccess = await ref
          .read(deleteRecipeControllerProvider.notifier)
          .deleteRecipe(recipeId);

      if (isSuccess) {
        if (context.mounted) {
          context.pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(floatingSnackBar("Recipe deleted"));
        }
      }
    }

    return AsyncValueWidget(
      value: controllerRecipe,
      data: (recipe) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(recipe.name),
          elevation: 0,
          backgroundColor: Colors.black38,
          actions: [
            IconButton(
              onPressed: () async {
                final confirmation = await showAlertDialog(
                  context: context,
                  title: "Delete Recipe",
                  content: "Are you sure you want to delete this recipe?",
                  cancelActionText: "Cancel",
                  defaultActionText: "Delete",
                );

                if (confirmation == true) {
                  deleteRecipe(recipe.id);
                }
              },
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () => context.goNamed(
                AppRoute.editRecipe.name,
                params: {
                  "id": recipe.id,
                },
              ),
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RecipeImageContainer(
                recipeImage: null,
                width: double.infinity,
                height: 250.0,
                borderRadius: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.p16,
                  vertical: Sizes.p24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    gapH8,
                    Text(
                      recipe.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    gapH16,
                    RecipeIngredientsSection(
                      recipeId: recipe.id,
                      ingredients: recipe.ingredients,
                    ),
                    gapH16,
                    RecipeDirectionsSection(
                      directions: recipe.directions,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error) {
        return ErrorScreenWidget(
          error: error,
          // Invalidate the cache so that the error state is not cached
          onDispose: () => ref.invalidate(
            recipeControllerProvider(recipeId),
          ),
        );
      },
    );
  }
}
