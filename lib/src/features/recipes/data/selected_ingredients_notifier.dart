import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedIngredientsNotifier extends ChangeNotifier {
  Set<String> _selectedIngredients = {};
  Set<String> get selectedIngredients => _selectedIngredients;

  void addSelectedIngredient(String ingredient) {
    _selectedIngredients.add(ingredient);
    notifyListeners();
  }

  void setSelectedIngredients(Set<String> ingredients) {
    _selectedIngredients = ingredients.map((e) => e).toSet();
    notifyListeners();
  }

  void removeSelectedIngredient(String ingredient) {
    _selectedIngredients.remove(ingredient);
    notifyListeners();
  }
}

final selectedIngredientsProvider =
    ChangeNotifierProvider((ref) => SelectedIngredientsNotifier());
