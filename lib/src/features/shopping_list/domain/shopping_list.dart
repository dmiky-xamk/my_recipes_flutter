// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:my_recipes/src/features/shopping_list/domain/shopping_list_ingredient.dart';

/// Model class representing a shopping list of [ShoppingListIngredient]s.
@immutable
class ShoppingList {
  const ShoppingList({this.ingredients = const []});

  final List<ShoppingListIngredient> ingredients;

  @override
  int get hashCode => ingredients.hashCode;

  ShoppingList copyWith({
    List<ShoppingListIngredient>? ingredients,
  }) {
    return ShoppingList(
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
    };
  }

  factory ShoppingList.fromMap(Map<String, dynamic> map) {
    return ShoppingList(
      ingredients: List<ShoppingListIngredient>.from(
        (map['ingredients'] as List<dynamic>).map<ShoppingListIngredient>(
          (x) => ShoppingListIngredient.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingList.fromJson(String source) =>
      ShoppingList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ShoppingList other) {
    if (identical(this, other)) return true;

    return listEquals(other.ingredients, ingredients);
  }

  @override
  String toString() => 'ShoppingList(ingredients: $ingredients)';
}

extension ShoppingListItems on ShoppingList {
  List<ShoppingListIngredient> get selectedItems =>
      ingredients.where((ing) => ing.isSelected).toList();

  List<ShoppingListIngredient> get unselectedItems =>
      ingredients.where((ing) => !ing.isSelected).toList();

  bool get isAnySelected => selectedItems.isNotEmpty;

  // List<ShoppingListIngredient> get ingredientsBelongingToRecipes =>
  //     ingredients.where((ing) => ing.recipeId != null).toList();

  // List<ShoppingListIngredient> get ingredientsNotBelongingToRecipes =>
  //     ingredients.where((ing) => ing.recipeId == null).toList();

  Map<String?, List<ShoppingListIngredient>> get groupedIngredients2 =>
      groupBy(ingredients, (ing) => ing.recipeId);

  Map<String?, List<ShoppingListIngredient>> get groupedIngredients {
    final nonNullGroups = groupBy(
        ingredients.where((ing) => ing.recipeId != null),
        (ing) => ing.recipeId);

    final nullGroup = {
      null: ingredients.where((ing) => ing.recipeId == null).toList()
    };

    return {...nonNullGroups, ...nullGroup};
  }

  ShoppingList getByRecipeId(String recipeId) {
    final ingredients = groupedIngredients[recipeId];

    return ShoppingList(ingredients: ingredients ?? []);
  }

  // List<ShoppingListIngredient> get sortedByRecipeId => ingredients
  //     .where((ing) => ing.recipeId != null)
  //     .toList()
  //     .followedBy(ingredients.where((ing) => ing.recipeId == null))
  //     .toList();
}
