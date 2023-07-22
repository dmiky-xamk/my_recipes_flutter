import 'package:flutter/widgets.dart';
import 'package:my_recipes/src/features/recipes/presentation/modify_recipe/recipe_form/recipe_form_text_field.dart';

// Helps to focus next text field widget
// https://stackoverflow.com/questions/52150677/how-to-shift-focus-to-the-next-textfield-in-flutter/60455958#60455958
extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild?.context?.widget
        is RecipeFormTextField);
  }
}

extension FocusUtility on FocusScopeNode {
  void nextEditableTextFocus() {
    do {
      (this).nextFocus();
    } while (focusedChild?.context?.widget is RecipeFormTextField);
  }
}
