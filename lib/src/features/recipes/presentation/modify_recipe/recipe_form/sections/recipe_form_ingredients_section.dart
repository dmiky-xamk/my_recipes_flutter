import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/common_widgets/icon_secondary_button.dart';
import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_model.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_text_field.dart';

import 'package:my_recipes/src/localization/string_hardcoded.dart';

class RecipeFormIngredientsSection extends StatefulWidget {
  const RecipeFormIngredientsSection({
    super.key,
    required this.recipe,
  });
  final RecipeFormModel recipe;

  @override
  State<RecipeFormIngredientsSection> createState() =>
      _RecipeFormIngredientsSectionState();
}

// final _formKeys = [UniqueKey()];

class _RecipeFormIngredientsSectionState
    extends State<RecipeFormIngredientsSection> {
  // Create a list of FocusNodes. One for each text field.
  late final List<FocusNode> _focusNodes;
  // final _focusNodes = <FocusNode>[widget.recipe.ingredients.length FocusNode()];

  @override
  void initState() {
    final ingredients = widget.recipe.ingredients;

    _focusNodes = ingredients.isEmpty
        ? [FocusNode()]
        : List.generate(
            widget.recipe.ingredients.length,
            (index) => FocusNode(),
          );

    super.initState();
  }

  void onAdd() {
    _focusNodes.add(FocusNode());

    setState(
      () {
        // widget.keys.add(UniqueKey());
        // debugPrint("widget.keys ${widget.keys}");

        widget.recipe.ingredients
            .add(Ingredient(amount: "", unit: "", name: ""));
      },
    );

    _focusNodes.last.requestFocus();
  }

  void onDelete(int index) {
    _focusNodes.removeAt(index);

    setState(
      () {
        widget.recipe.ingredients.removeAt(index);
        // widget.keys.removeAt(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLastIngredient = widget.recipe.ingredients.length == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Ingredients".hardcoded,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        gapH16,
        ListView.builder(
          itemCount: widget.recipe.ingredients.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: IngredientInputsRow(
                        focusNode: _focusNodes[index],
                        // Provide a unique key to each row so that delete works
                        // key: widget
                        //     .keys[index], // TODO: Does this work as expected?
                        key: UniqueKey(),
                        recipe: widget.recipe,
                        index: index,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          isLastIngredient ? null : onDelete(index),
                      icon: isLastIngredient
                          ? const Icon(
                              Icons.delete,
                              color: Colors.black38,
                            )
                          : const Icon(Icons.delete),
                    ),
                  ],
                ),
                gapH8,
              ],
            );
          },
        ),
        IconSecondaryButton(
          text: "Add ingredient".hardcoded,
          isLoading: false,
          icon: Icons.add,
          onPressed: onAdd,
        ),
      ],
    );
  }
}

class IngredientInputsRow extends StatefulWidget {
  const IngredientInputsRow({
    super.key,
    required this.index,
    required this.recipe,
    this.focusNode,
  });
  final RecipeFormModel recipe;
  final int index;
  final FocusNode? focusNode;

  @override
  State<IngredientInputsRow> createState() => _IngredientInputsRowState();
}

class _IngredientInputsRowState extends State<IngredientInputsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RecipeFormTextField(
            label: "Amount".hardcoded,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            value: widget.recipe.ingredients[widget.index].amount,
            onChanged: (value) => widget.recipe.editIngredient(
              widget.index,
              "amount",
              value,
            ),
          ),
        ),
        gapW8,
        Expanded(
          child: RecipeFormTextField(
            // key: EditIngredientsSection.ingredientUnitKey,
            label: "Unit".hardcoded,
            textInputAction: TextInputAction.next,
            value: widget.recipe.ingredients[widget.index].unit,
            onChanged: (value) => widget.recipe.editIngredient(
              widget.index,
              "unit",
              value,
            ),
          ),
        ),
        gapW8,
        Expanded(
          flex: 2,
          child: RecipeFormTextField(
            label: "Name".hardcoded,
            value: widget.recipe.ingredients[widget.index].name,
            onChanged: (value) => widget.recipe.editIngredient(
              widget.index,
              "name",
              value,
            ),
            validator: (value) => (value == null || value.isEmpty)
                ? "Name is required".hardcoded
                : null,
          ),
        ),
      ],
    );
  }
}
