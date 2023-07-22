// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:my_recipes/src/features/recipes/domain/directions.dart';
import 'package:my_recipes/src/features/recipes/domain/ingredient.dart';

/// * The product identifier is an important concept and can have its own type.
typedef ProductId = String;

/// Class representing a recipe.
class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.ingredients,
    required this.directions,
  });

  final String id;
  final String name;
  final String image;
  final String description;
  final List<Ingredient> ingredients;
  final List<Direction> directions;

  Recipe copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    List<Ingredient>? ingredients,
    List<Direction>? directions,
  }) {
    return Recipe(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      directions: directions ?? this.directions,
    );
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        listEquals(other.ingredients, ingredients) &&
        listEquals(other.directions, directions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        ingredients.hashCode ^
        directions.hashCode;
  }

  @override
  String toString() {
    return 'Recipe(id: $id, name: $name, description: $description, ingredients: $ingredients, directions: $directions)';
  }

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

  factory Recipe.fromJson(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
      ingredients: List<Ingredient>.from(
        (map['ingredients'] as List<dynamic>).map<Ingredient>(
          (x) => Ingredient.fromMap(x as Map<String, dynamic>),
        ),
      ),
      directions: List<Direction>.from(
        (map['directions'] as List<dynamic>).map<Direction>(
          (x) => Direction.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  // factory Recipe.fromJson(String source) =>
  //     Recipe.fromMap(json.decode(source) as Map<String, dynamic>);
}
