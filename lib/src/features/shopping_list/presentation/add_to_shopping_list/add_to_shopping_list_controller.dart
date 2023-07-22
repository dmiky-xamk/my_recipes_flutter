// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_recipes/src/features/shopping_list/application/shopping_list_service.dart';

// class AddToShoppingListController extends StateNotifier<AsyncValue<void>> {
//   AddToShoppingListController({required this.shoppingListService})
//       : super(const AsyncData(null));

//   final ShoppingListService shoppingListService;
//   bool _isBeingAdded = false;

//   // * Reset the variable after it has been used
//   get isBeingAdded {
//     if (_isBeingAdded == true) {
//       _isBeingAdded = false;
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<void> addIngredient(String ingredientName) async {
//     _isBeingAdded = true;
//     state = await AsyncValue.guard(
//       () => shoppingListService.addIngredient(ingredientName),
//     );
//   }
// }

// final addToShoppingListControllerProvider =
//     StateNotifierProvider<AddToShoppingListController, AsyncValue<void>>((ref) {
//   debugPrint('addToShoppingListControllerProvider');
//   // ref.keepAlive();
//   ref.onDispose(() {
//     debugPrint('addToShoppingListControllerProvider onDispose');
//   });

//   return AddToShoppingListController(
//       shoppingListService: ref.watch(shoppingListServiceProvider));
// });
