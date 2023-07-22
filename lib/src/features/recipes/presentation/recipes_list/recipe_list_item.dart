import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/recipe_image_container.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipes_list/recipe_list_item_text_content.dart';

class RecipeListItem extends StatelessWidget {
  const RecipeListItem(
      {super.key, required this.recipe, required this.onPressed});

  final Recipe recipe;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * AspectRatio?
              const RecipeImageContainer(
                recipeImage: null,
                width: 90.0,
                height: 90.0,
                borderRadius: Sizes.p8,
              ),
              gapW16,
              Expanded(
                child: RecipeListItemTextContent(
                  name: recipe.name,
                  description: recipe.description,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
