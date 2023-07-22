import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_model.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_text_field.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

class RecipeFormInformationSection extends StatefulWidget {
  const RecipeFormInformationSection({super.key, required this.recipe});
  final RecipeFormModel recipe;

  @override
  State<RecipeFormInformationSection> createState() =>
      RecipeFormInformationSectionState();
}

class RecipeFormInformationSectionState
    extends State<RecipeFormInformationSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Recipe information".hardcoded,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        gapH16,
        RecipeFormTextField(
          label: "Name *".hardcoded,
          value: widget.recipe.name,
          onChanged: (value) => widget.recipe.name = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Name is required".hardcoded;
            }
            return null;
          },
        ),
        gapH8,
        RecipeFormTextField(
          label: "Description".hardcoded,
          value: widget.recipe.description,
          onChanged: (value) => widget.recipe.description = value,
        ),
      ],
    );
  }
}
