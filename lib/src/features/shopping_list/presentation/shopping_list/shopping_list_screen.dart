import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/common_widgets/async_value_widget.dart';
import 'package:my_recipes/src/features/shopping_list/application/shopping_list_service.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list.dart';
import 'package:my_recipes/src/features/shopping_list/presentation/add_to_shopping_list/add_to_shopping_list_widget.dart';
import 'package:my_recipes/src/features/shopping_list/presentation/shopping_list/shopping_list_builder.dart';
import 'package:my_recipes/src/features/shopping_list/presentation/shopping_list/shopping_list_screen_controller.dart';
import 'package:my_recipes/src/features/shopping_list/presentation/shopping_list/shopping_list_ingredient_item.dart';
import 'package:my_recipes/src/utils/async_value_ui.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      shoppingListScreenControllerProvider2,
      (previous, state) {
        state.showAlertDialogOnError(context);
      },
    );

    final shoppingListValue = ref.watch(shoppingListWatchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping list"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: shoppingListValue.valueOrNull?.isAnySelected ?? false
                ? () => ref
                    .read(shoppingListScreenControllerProvider2.notifier)
                    .deleteSelectedIngredients()
                : null,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AsyncValueWidget<ShoppingList>(
              value: shoppingListValue,
              data: (shoppingList) => ShoppingListBuilder(
                ingredients: shoppingList.groupedIngredients,
                ingredientsBuilder: (_, ingredient, recipeId) {
                  return ShoppingListIngredientItem(
                    item: ingredient,
                  );
                },
              ),
            ),
          ),
          const AddToShoppingListWidget()
        ],
      ),
    );
  }
}
