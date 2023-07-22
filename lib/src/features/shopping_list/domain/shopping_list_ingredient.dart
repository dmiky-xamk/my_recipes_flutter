// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class ShoppingListIngredient {
  const ShoppingListIngredient({
    required this.id,
    this.recipeId,
    this.recipeName,
    required this.ingredientName,
    required this.isSelected,
  });

  final int id;
  final String? recipeId;
  final String? recipeName;
  final String ingredientName;
  final bool isSelected;

  ShoppingListIngredient copyWith({
    int? id,
    String? recipeId,
    String? recipeName,
    String? ingredientName,
    bool? isSelected,
  }) {
    return ShoppingListIngredient(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      recipeName: recipeName ?? this.recipeName,
      ingredientName: ingredientName ?? this.ingredientName,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  String toString() {
    return 'ShoppingListIngredient(id: $id, recipeId: $recipeId, recipeName: $recipeName ingredientName: $ingredientName, isSelected: $isSelected)';
  }

  @override
  bool operator ==(covariant ShoppingListIngredient other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.recipeId == recipeId &&
        other.recipeName == recipeName &&
        other.ingredientName == ingredientName &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        recipeId.hashCode ^
        recipeName.hashCode ^
        ingredientName.hashCode ^
        isSelected.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'recipeId': recipeId,
      'recipeName': recipeName,
      'name': ingredientName,
      'isSelected': isSelected,
    };
  }

  factory ShoppingListIngredient.fromMap(Map<String, dynamic> map) {
    return ShoppingListIngredient(
      id: map['id'] as int,
      recipeId: map['recipeId'] != null ? map['recipeId'] as String : null,
      recipeName:
          map['recipeName'] != null ? map['recipeName'] as String : null,
      ingredientName: map['name'] as String,
      isSelected: map['isSelected'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingListIngredient.fromJson(String source) =>
      ShoppingListIngredient.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
