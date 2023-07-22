import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/common_widgets/async_value_widget.dart';

import 'package:my_recipes/src/features/recipes/domain/recipe.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipes_list/recipes_list_controller.dart';
import 'package:my_recipes/src/features/search/presentation/ingredient_select_dropdown.dart';
import 'package:my_recipes/src/features/search/presentation/matched_recipes_list.dart';
import 'package:my_recipes/src/features/search/presentation/matched_recipes_controller.dart';
import 'package:select2dot1/select2dot1.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p8),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, _) {
                final asyncRecipes = ref.watch(recipesListControllerProvider);

                return AsyncValueWidget<List<Recipe>>(
                  value: asyncRecipes,
                  data: (recipes) {
                    final models = _createCategoryModels(recipes);

                    return Expanded(
                      child: Column(
                        children: [
                          const MatchedRecipesList(),
                          IngredientSelectDropdown(
                            selectableIngredients: models,
                            onSelectablesChange: (values) => ref
                                .read(matchedRecipesControllerProvider.notifier)
                                .updateMatchedRecipes(recipes, values),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<SingleCategoryModel> _createCategoryModels(
  List<Recipe> recipes,
) {
  SingleItemCategoryModel createSelectableIngredient(String ingredientName) {
    return SingleItemCategoryModel(
      nameSingleItem: ingredientName,
    );
  }

  final ingredientNames = recipes
      .expand((recipe) => recipe.ingredients.map((ing) => ing.name))
      .sorted((a, b) => a.compareTo(b))
      .toSet()
      .map((name) => createSelectableIngredient(name))
      .toList();

  return [
    SingleCategoryModel(
      nameCategory: 'Ingredients',
      singleItemCategoryList: ingredientNames,
    ),
  ];
}
