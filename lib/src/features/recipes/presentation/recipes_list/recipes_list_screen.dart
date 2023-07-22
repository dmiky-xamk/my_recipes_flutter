import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/authentication/data/auth_repository.dart';
import 'package:my_recipes/src/features/common_widgets/async_value_widget.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipes_list/recipe_list_item.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipes_list/recipes_list_controller.dart';
import 'package:my_recipes/src/routing/app_router.dart';

class RecipesListScreen extends ConsumerWidget {
  const RecipesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final recipesListValue = ref.watch(recipesListFutureProvider);
    // final repoRecipes = ref.watch(recipesListFutureProvider2);
    final controllerRecipes =
        ref.watch(recipesListControllerProvider); // * Controller
    // final repoRecipes = ref.watch(recipesListFutureProvider2); // * Repo
    // ref.listen(recipesRepositoryProvider)

    // Testing
    // final newControllerRecipes = ref.watch(recipesStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
              // ref.invalidate(recipesListControllerProvider);
            },
          ),
        ],
      ),
      body: AsyncValueWidget(
        value: controllerRecipes,
        data: (recipes) => ListView.builder(
          restorationId: "recipesListView",
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];

            if (recipes.isEmpty) {
              return const Center(
                child: Text("Add recipes with the + button"),
              );
            }

            return Padding(
              padding: EdgeInsets.only(
                left: Sizes.p16,
                right: Sizes.p16,
                top: index == 0 ? Sizes.p16 : 0,
              ),
              child: RecipeListItem(
                recipe: recipe,
                onPressed: () => context.goNamed(
                  AppRoute.recipe.name,
                  params: {
                    "id": recipe.id,
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.goNamed(
          AppRoute.createRecipe.name,
        ),
      ),
    );
  }
}
