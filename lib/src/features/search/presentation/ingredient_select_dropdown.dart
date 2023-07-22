import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/search/presentation/ingredient_input_chip.dart';
import 'package:select2dot1/select2dot1.dart';

class IngredientSelectDropdown extends StatelessWidget {
  const IngredientSelectDropdown({
    super.key,
    required this.selectableIngredients,
    required this.onSelectablesChange,
  });

  final List<SingleCategoryModel> selectableIngredients;
  final Function(Iterable<String> values) onSelectablesChange;

  @override
  Widget build(BuildContext context) {
    final Set<String> lockedIngredients = {};

    return Select2dot1(
      globalSettings: GlobalSettings(mainColor: Theme.of(context).primaryColor),
      pillboxSettings: PillboxSettings(
        defaultDecoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[500]!,
          ),
          borderRadius: BorderRadius.circular(Sizes.p4),
        ),
      ),
      selectEmptyInfoSettings: SelectEmptyInfoSettings(
        text: 'Select ingredients',
        textStyle: TextStyle(
          fontSize: Sizes.p16,
          color: Colors.grey[700],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 4,
        ),
      ),
      selectDataController: SelectDataController(
        data: selectableIngredients,
      ),
      onChanged: (value) {
        final selectedValues = value.map(
          (e) => e.nameSingleItem,
        );

        onSelectablesChange(selectedValues);
      },
      selectChipBuilder: (context, selectChipDetails) {
        return IngredientInputChip(
          ingredientName: selectChipDetails.singleItemCategory.nameSingleItem,
          onDelete: () =>
              selectChipDetails.selectDataController.removeSingleSelectedChip(
            selectChipDetails.singleItemCategory,
          ),
          lockedIngredients: lockedIngredients,
        );
      },
    );
  }
}
