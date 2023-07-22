import 'package:flutter/material.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list.dart';
import 'package:my_recipes/src/features/shopping_list/domain/shopping_list_ingredient.dart';

extension MutableShoppingList on ShoppingList {
  ShoppingList toggleIngredient(int id) {
    final newIngredients = ingredients.map((ing) {
      if (ing.id == id) {
        return ing.copyWith(isSelected: !ing.isSelected);
      }
      return ing;
    }).toList();

    return copyWith(ingredients: newIngredients);
  }

  ShoppingList addIngredient(
      String ingredientName, String? recipeId, String? recipeName) {
    final newIngredients = [
      ...ingredients,
      ShoppingListIngredient(
        id: UniqueKey().hashCode,
        recipeId: recipeId,
        recipeName: recipeName,
        ingredientName: ingredientName,
        isSelected: false,
      ),
    ];

    return copyWith(ingredients: newIngredients);
  }

  ShoppingList deleteIngredient(int id) {
    final newIngredients = ingredients.where((ing) => ing.id != id).toList();

    return copyWith(ingredients: newIngredients);
  }

  ShoppingList deleteSelectedIngredients() {
    final newIngredients =
        ingredients.where((ing) => ing.isSelected == false).toList();

    return copyWith(ingredients: newIngredients);
  }

  ShoppingList deleteRecipeIngredient(String ingredientName, String recipeId) {
    final newIngredients = ingredients
        .where((ing) =>
            ing.ingredientName != ingredientName || ing.recipeId != recipeId)
        .toList();

    return copyWith(ingredients: newIngredients);
  }
}
