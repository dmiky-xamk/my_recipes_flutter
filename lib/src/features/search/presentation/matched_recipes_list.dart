import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/search/presentation/matched_recipe_card.dart';
import 'package:my_recipes/src/features/search/presentation/matched_recipes_controller.dart';

class MatchedRecipesList extends ConsumerWidget {
  const MatchedRecipesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchedRecipes = ref.watch(matchedRecipesControllerProvider);

    return Expanded(
      child: ListView.builder(
        itemCount: matchedRecipes.length,
        itemBuilder: (context, index) {
          return MatchedRecipeCard(
            recipe: matchedRecipes.elementAt(index),
          );
        },
      ),
    );
  }
}
