// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/shopping_list/application/shopping_list_service.dart';

class ShoppingListScreenController extends StateNotifier<AsyncValue<void>> {
  ShoppingListScreenController({required this.shoppingListService})
      : super(const AsyncData(null));

  final ShoppingListService shoppingListService;
  bool _isBeingAdded = false;

  // * Reset the variable after it has been retrieved
  get isBeingAdded {
    if (_isBeingAdded == true) {
      _isBeingAdded = false;
      return true;
    } else {
      return false;
    }
  }

  Future<void> addIngredient(String ingredientName) async {
    _isBeingAdded = true;
    state = await AsyncValue.guard(
      () => shoppingListService.addIngredient(ingredientName, null, null),
    );
  }

  Future<void> deleteSelectedIngredients() async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard(
        () => shoppingListService.deleteSelectedIngredients());
  }

  Future<void> deleteIngredient(int id) async {
    state = const AsyncLoading<void>();

    state =
        await AsyncValue.guard(() => shoppingListService.deleteIngredient(id));
  }

  Future<void> toggleIngredient(int id) async {
    state = const AsyncLoading<void>();

    state =
        await AsyncValue.guard(() => shoppingListService.toggleIngredient(id));
  }
}

final shoppingListScreenControllerProvider2 =
    StateNotifierProvider<ShoppingListScreenController, AsyncValue<void>>(
  (ref) {
    final shoppingListService = ref.watch(shoppingListServiceProvider);

    return ShoppingListScreenController(
      shoppingListService: shoppingListService,
    );
  },
);
