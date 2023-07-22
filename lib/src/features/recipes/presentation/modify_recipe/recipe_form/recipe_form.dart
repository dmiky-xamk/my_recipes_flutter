import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/common_widgets/alert_dialogs.dart';
import 'package:my_recipes/src/features/common_widgets/floating_snack_bar.dart';
import 'package:my_recipes/src/features/common_widgets/primary_button.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_model.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/sections/recipe_form_directions_section.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/sections/recipe_form_information_section.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/sections/recipe_form_ingredients_section.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_controller.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_state.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/sections/recipe_form_image_section.dart';
import 'package:my_recipes/src/features/recipes/presentation/recipe_screen/recipe_controller.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';
import 'package:my_recipes/src/routing/app_router.dart';
import 'package:my_recipes/src/utils/async_value_ui.dart';

class RecipeForm extends ConsumerStatefulWidget {
  const RecipeForm({
    super.key,
    required this.recipe,
    required this.formType,
  });
  final RecipeFormModel recipe;
  final RecipeFormType formType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecipeFormState();
}

class _RecipeFormState extends ConsumerState<RecipeForm> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(recipeFormControllerProvider(widget.formType).notifier);

      final recipe = await controller.submit(widget.recipe);

      // If the submit was successful, update the recipe controller and navigate
      if (recipe != null) {
        ref
            .read(recipeControllerProvider(recipe.id).notifier)
            .updateState(recipe);

        if (context.mounted) {
          if (widget.formType == RecipeFormType.create) {
            // Navigate to the newly created recipe
            context.goNamed(
              AppRoute.recipe.name,
              params: {
                "id": recipe.id,
              },
            );
            ScaffoldMessenger.of(context).showSnackBar(
              floatingSnackBar(
                "Recipe created".hardcoded,
              ),
            );
          } else {
            // Pop the edit screen
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              floatingSnackBar(
                "Recipe updated".hardcoded,
              ),
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      recipeFormControllerProvider(widget.formType)
          .select((state) => state.value),
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(recipeFormControllerProvider(widget.formType));

    return Form(
      key: _formKey,
      onWillPop: () async {
        return await showAlertDialog(
              context: context,
              title: "Discard changes?".hardcoded,
              content:
                  "Are you sure you want to discard your changes?".hardcoded,
              cancelActionText: "Cancel".hardcoded,
              defaultActionText: "Discard".hardcoded,
            ) ??
            false;
      },
      child: Column(
        children: [
          const RecipeFormImageSection(),
          Padding(
            padding: const EdgeInsets.only(
              top: Sizes.p24,
              left: Sizes.p16,
              right: Sizes.p16,
              bottom: Sizes.p8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RecipeFormInformationSection(recipe: widget.recipe),
                gapH16,
                RecipeFormIngredientsSection(recipe: widget.recipe),
                gapH16,
                RecipeFormDirectionsSection(recipe: widget.recipe),
                gapH16,
                PrimaryButton(
                  text: "Save".hardcoded,
                  loadingText: "Saving your recipe...".hardcoded,
                  isLoading: state.value.isLoading,
                  onPressed: state.value.isLoading ? null : _submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
