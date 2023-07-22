import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/shopping_list/data/shopping_list_repository.dart';
import 'package:my_recipes/src/features/shopping_list/domain/mutable_shopping_list.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list.dart';

class ShoppingListService {
  ShoppingListService({required this.shoppingListRepository});
  final ShoppingListRepository shoppingListRepository;

  Future<ShoppingList> _fetchShoppingList() async {
    return await shoppingListRepository.fetchShoppingList();
  }

  Future<void> _setShoppingList(ShoppingList shoppingList) async {
    await shoppingListRepository.setShoppingList(shoppingList);
  }

  Future<void> toggleIngredient(int id) async {
    final shoppingList = await _fetchShoppingList();
    final updated = shoppingList.toggleIngredient(id);
    await _setShoppingList(updated);
  }

  Future<void> addIngredient(
    String ingredientName,
    String? recipeId,
    String? recipeName,
  ) async {
    final shoppingList = await _fetchShoppingList();
    final updated =
        shoppingList.addIngredient(ingredientName, recipeId, recipeName);
    await _setShoppingList(updated);
  }

  Future<void> deleteIngredient(int id) async {
    final shoppingList = await _fetchShoppingList();
    final updated = shoppingList.deleteIngredient(id);
    await _setShoppingList(updated);
  }

  Future<void> deleteRecipeIngredient(
    String ingredientName,
    String recipeId,
  ) async {
    final shoppingList = await _fetchShoppingList();
    final updated =
        shoppingList.deleteRecipeIngredient(ingredientName, recipeId);
    await _setShoppingList(updated);
  }

  Future<void> deleteSelectedIngredients() async {
    final shoppingList = await _fetchShoppingList();
    final updated = shoppingList.deleteSelectedIngredients();
    await _setShoppingList(updated);
  }

  Future<ShoppingList> fetchRecipeShoppingList(String recipeId) async {
    final shoppingList = await _fetchShoppingList();
    return shoppingList.getByRecipeId(recipeId);
  }

  Future<ShoppingList> watchRecipeShoppingList(String recipeId) async {
    final shoppingList = await _fetchShoppingList();
    return shoppingList.getByRecipeId(recipeId);
  }
}

final shoppingListServiceProvider = Provider<ShoppingListService>(
  (ref) => ShoppingListService(
    shoppingListRepository: ref.watch(shoppingListRepositoryProvider),
  ),
);

final shoppingListWatchProvider = StreamProvider<ShoppingList>(
  (ref) {
    return ref.watch(shoppingListRepositoryProvider).watchShoppingList();
  },
);

final shoppingRecipeWatchProvider = StreamProvider.family<ShoppingList, String>(
  (ref, recipeId) {
    final list = ref.watch(shoppingListRepositoryProvider).watchShoppingList();

    return list.map((event) => event.getByRecipeId(recipeId));
  },
);

// final shoppingListFutureProvider =
//     FutureProvider.autoDispose.family<ShoppingList, String>(
//   (ref, id) async {
//     return await ref
//         .watch(shoppingListServiceProvider)
//         .fetchRecipeShoppingList(id);
//   },
// );

// final shoppingListFutureProvider2 =
//     FutureProvider.autoDispose.family<ShoppingList, String>(
//   (ref, id) async {
//     return await ref
//         .watch(shoppingListServiceProvider)
//         .fetchRecipeShoppingList(id);
//   },
// );
