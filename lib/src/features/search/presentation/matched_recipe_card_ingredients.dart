import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';

class MatchedRecipeCardIngredients extends StatelessWidget {
  const MatchedRecipeCardIngredients(
      {super.key, required this.ingredients, this.secondary = false});
  final Iterable<Ingredient> ingredients;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: Sizes.p8,
      spacing: Sizes.p16,
      children: ingredients
          .map(
            (ingredient) => Text(
              ingredient.name,
              style: _createTextStyle(secondary),
            ),
          )
          .toList(),
    );
  }

  TextStyle? _createTextStyle(bool secondary) {
    return secondary ? TextStyle(color: Colors.grey[600]) : null;
  }
}
