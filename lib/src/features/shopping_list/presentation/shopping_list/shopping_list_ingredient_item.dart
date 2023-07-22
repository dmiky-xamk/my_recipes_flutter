import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list_ingredient.dart';
import 'package:my_recipes/src/features/shopping_list/presentation/shopping_list/shopping_list_screen_controller.dart';

class ShoppingListIngredientItem extends ConsumerWidget {
  const ShoppingListIngredientItem({
    super.key,
    required this.item,
  });
  final ShoppingListIngredient item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(item.id.toString()),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: Sizes.p24),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => ref
          .read(shoppingListScreenControllerProvider2.notifier)
          .deleteIngredient(item.id),
      child: CheckboxListTile(
        title: Text(item.ingredientName),
        controlAffinity: ListTileControlAffinity.trailing,
        value: item.isSelected,
        onChanged: (newValue) => ref
            .read(shoppingListScreenControllerProvider2.notifier)
            .toggleIngredient(item.id),
      ),
    );
  }
}
