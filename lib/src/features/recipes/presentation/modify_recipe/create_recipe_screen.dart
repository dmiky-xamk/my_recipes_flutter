import 'package:flutter/material.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_model.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_state.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

class CreateRecipeScreen extends StatelessWidget {
  CreateRecipeScreen({super.key});

  final recipe = RecipeFormModel.create();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create".hardcoded),
      ),
      body: SingleChildScrollView(
        child: RecipeForm(
          recipe: recipe,
          formType: RecipeFormType.create,
        ),
      ),
    );
  }
}
