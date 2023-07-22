import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/common_widgets/icon_secondary_button.dart';
import 'package:my_recipes/src/features/recipes/domain/directions.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_model.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_text_field.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

class RecipeFormDirectionsSection extends ConsumerStatefulWidget {
  const RecipeFormDirectionsSection({
    super.key,
    required this.recipe,
  });

  final RecipeFormModel recipe;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditDirectionsSectionState();
}

class _EditDirectionsSectionState
    extends ConsumerState<RecipeFormDirectionsSection> {
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    final directions = widget.recipe.directions;

    _focusNodes = directions.isEmpty
        ? [FocusNode()]
        : List.generate(
            widget.recipe.directions.length,
            (index) => FocusNode(),
          );

    super.initState();
  }

  void onAdd() {
    _focusNodes.add(FocusNode());

    setState(
      () => widget.recipe.directions.add(Direction(step: "")),
    );

    _focusNodes.last.requestFocus();
  }

  void onDelete(int index) {
    _focusNodes.removeAt(index);

    setState(
      () => widget.recipe.directions.removeAt(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Directions".hardcoded,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        gapH16,
        ListView.builder(
          key: GlobalKey(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.recipe.directions.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RecipeFormTextField(
                        focusNode: _focusNodes[index],
                        label: "Step ${index + 1}".hardcoded,
                        value: widget.recipe.directions[index].step,
                        onChanged: (value) =>
                            widget.recipe.editDirection(index, value),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => onDelete(index),
                    ),
                  ],
                ),
                gapH8,
              ],
            );
          },
        ),
        gapH8,
        IconSecondaryButton(
          text: "Add step".hardcoded,
          isLoading: false,
          icon: Icons.add,
          onPressed: onAdd,
        ),
      ],
    );
  }
}
