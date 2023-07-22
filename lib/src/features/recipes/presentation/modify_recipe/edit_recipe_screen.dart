import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/api/api_error_response.dart';
import 'package:my_recipes/src/features/common_widgets/async_value_widget.dart';
import 'package:my_recipes/src/features/common_widgets/error_message_widget.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_model.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_state.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/recipe_controller.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

class EditRecipeScreen extends ConsumerStatefulWidget {
  const EditRecipeScreen({super.key, required this.recipeId});
  final String recipeId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditRecipeState();
}

class _EditRecipeState extends ConsumerState<EditRecipeScreen> {
  late RecipeFormModel? recipe;

  // @override
  // void initState() {
  //   // final rec = ref.read(recipeProvider(widget.recipeId));
  //   // final rec = ref.read(recipeFutureProvider2(widget.recipeId));
  //   final rec = ref.read(recipeFutureProvider2("1337"));

  //   if (rec.valueOrNull != null) {
  //     recipe = RecipeFormModel.edit(rec.valueOrNull!);
  //   } else {
  //     recipe = null;
  //   }
  //   // recipe = RecipeFormModel.edit(rec.value!);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: Use the controller to fetch the cached recipe
    // final rec = ref.watch(recipeFutureProvider2(widget.recipeId));

    final controllerRecipe =
        ref.watch(recipeControllerProvider(widget.recipeId));

    // TODO: Testing
    // final newControllerRecipe =
    //     ref.watch(testRecipeControllerProvider(widget.recipeId));

    debugPrint("Recipe: $controllerRecipe");

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit".hardcoded),
      ),
      body: AsyncValueWidget(
        value: controllerRecipe,
        data: (value) {
          recipe = RecipeFormModel.edit(value);

          return SingleChildScrollView(
            child: RecipeForm(
              recipe: recipe!,
              formType: RecipeFormType.edit,
            ),
          );
        },
        error: (error) {
          return Center(
            child: ErrorMessageWidget(
                errorMessage: (error as ApiErrorResponse).title),
          );
        },
      ),
    );
  }
}
