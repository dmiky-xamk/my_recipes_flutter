import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:my_recipes/src/features/recipes/domain/directions.dart';
import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';
import 'package:my_recipes/src/features/recipes/domain/recipe.dart';

class RecipeFormModel {
  RecipeFormModel(
    this.id,
    this.name,
    this.image,
    this.description,
    this.ingredients,
    this.directions,
  );

  RecipeFormModel.fromList(
    this.ingredients,
    this.directions,
  )   : name = "",
        description = "",
        image = "";

  RecipeFormModel.create()
      : name = "",
        description = "",
        image = "",
        ingredients = [Ingredient(amount: "", unit: "", name: "")],
        directions = [Direction(step: "")];

  RecipeFormModel.edit(Recipe recipe)
      : id = recipe.copyWith().id,
        name = recipe.copyWith().name,
        image = recipe.copyWith().image,
        description = recipe.copyWith().description,
        ingredients = [...recipe.ingredients],
        directions = [...recipe.directions];

  // Id is only used for editing recipes.
  String? id;
  String name;
  String image = "";
  String description;
  final List<Ingredient> ingredients;
  final List<Direction> directions;

  void editDirection(int index, String value) {
    directions[index] = Direction(step: value);
  }

  void editIngredient(int index, String type, String value) {
    ingredients[index] = Ingredient(
      amount: type == "amount" ? value : ingredients[index].amount,
      unit: type == "unit" ? value : ingredients[index].unit,
      name: type == "name" ? value : ingredients[index].name,
    );
  }

  @override
  String toString() =>
      'CreateRecipeModel(name: $name, description: $description, ingredients: $ingredients, directions: $directions)';

  @override
  bool operator ==(covariant RecipeFormModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.ingredients, ingredients) &&
        listEquals(other.directions, directions);
  }

  @override
  int get hashCode => ingredients.hashCode ^ directions.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'directions': directions.map((x) => x.toMap()).toList(),
    };
  }

  factory RecipeFormModel.fromMap(Map<String, dynamic> map) {
    return RecipeFormModel.fromList(
      List<Ingredient>.from(
        (map['ingredients'] as List<int>).map<Ingredient>(
          (x) => Ingredient.fromMap(x as Map<String, dynamic>),
        ),
      ),
      List<Direction>.from(
        (map['directions'] as List<int>).map<Direction>(
          (x) => Direction.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeFormModel.fromJson(String source) =>
      RecipeFormModel.fromMap(json.decode(source) as Map<String, dynamic>);

  RecipeFormModel copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    List<Ingredient>? ingredients,
    List<Direction>? directions,
  }) {
    return RecipeFormModel(
      id ?? this.id,
      name ?? this.name,
      image ?? this.image,
      description ?? this.description,
      ingredients ?? this.ingredients,
      directions ?? this.directions,
    );
  }
}
