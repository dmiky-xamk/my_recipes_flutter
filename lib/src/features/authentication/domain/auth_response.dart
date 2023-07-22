import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:my_recipes/src/features/recipes/domain/recipe.dart';

class AuthResponse {
  AuthResponse({
    required this.token,
    required this.email,
    required this.recipes,
  });

  String token;
  String email;
  List<Recipe> recipes;

  AuthResponse copyWith({
    String? token,
    String? email,
    List<Recipe>? recipes,
  }) {
    return AuthResponse(
      token: token ?? this.token,
      email: email ?? this.email,
      recipes: recipes ?? this.recipes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'email': email,
      'recipes': recipes.map((x) => x.toMap()).toList(),
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      token: map['token'] as String,
      email: map['email'] as String,
      recipes: List<Recipe>.from(
        (map['recipes'] as List<dynamic>).map<Recipe>(
          (x) => Recipe.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthResponse(token: $token, email: $email, recipes: $recipes)';

  @override
  bool operator ==(covariant AuthResponse other) {
    if (identical(this, other)) return true;

    return other.token == token &&
        other.email == email &&
        listEquals(other.recipes, recipes);
  }

  @override
  int get hashCode => token.hashCode ^ email.hashCode ^ recipes.hashCode;
}
