// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Form type for the recipe form
enum RecipeFormType { create, edit }

mixin RecipeValidators {
  String? validateRecipeName(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateIngredientName(String? value) {
    if (value == null || value.toString().trim().isEmpty) {
      return 'Ingredients are required';
    }
    return null;
  }
}

class RecipeFormState with RecipeValidators {
  RecipeFormState({
    required this.formType,
    this.value = const AsyncData(null),
  });

  final RecipeFormType formType;
  final AsyncValue<void> value;

  RecipeFormState copyWith({
    RecipeFormType? formType,
    AsyncValue<void>? value,
  }) {
    return RecipeFormState(
      formType: formType ?? this.formType,
      value: value ?? this.value,
    );
  }
}
