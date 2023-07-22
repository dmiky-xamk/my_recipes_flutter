import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/common_widgets/centered_text_widget.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list_ingredient.dart';
import 'package:my_recipes/src/features/shopping_list/presentation/shopping_list/shopping_list_screen_controller.dart';

class ShoppingListBuilder extends ConsumerWidget {
  const ShoppingListBuilder({
    super.key,
    required this.ingredients,
    required this.ingredientsBuilder,
  });

  final Map<String?, List<ShoppingListIngredient>> ingredients;
  final Widget Function(BuildContext, ShoppingListIngredient, String?)
      ingredientsBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ingredients.isEmpty) {
      return const CenteredTextWidget(
        text: "Your shopping list is still empty",
      );
    }

    final scrollController = ScrollController();
    void scrollToLatest() async {
      debugPrint("Scrolling to the latest ingredient");
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    }

    // Scroll to the bottom after the widget re-renders,
    // if an ingredient was added to the shopping list.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final wasIngredientAdded = ref
            .read(shoppingListScreenControllerProvider2.notifier)
            .isBeingAdded;

        if (wasIngredientAdded) {
          debugPrint("Scrolling to the latest ingredient");
          scrollToLatest();
        }
      },
    );

    return ListView.builder(
      controller: scrollController,
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final recipeId = ingredients.keys.elementAt(index);
        final recipeIngredients = ingredients[recipeId]!;

        // * Custom styles for ingredients that belong to a recipe.
        if (recipeId != null) {
          final recipeName = recipeIngredients.first.recipeName;
          return Column(
            children: [
              if (index == 0) gapH16,
              Text(recipeName ?? recipeId),
              for (var ingredient in recipeIngredients)
                ingredientsBuilder(context, ingredient, recipeId),
              const Divider(
                indent: Sizes.p16,
                endIndent: Sizes.p16,
              )
            ],
          );
        } else {
          return Column(
            children: [
              for (var ingredient in recipeIngredients)
                ingredientsBuilder(context, ingredient, recipeId),
            ],
          );
        }
      },
    );
  }
}
