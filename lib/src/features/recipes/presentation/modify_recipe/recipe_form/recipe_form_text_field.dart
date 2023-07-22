import 'package:flutter/material.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

/// Reusable text field for [RecipeForm].
class RecipeFormTextField extends StatefulWidget {
  const RecipeFormTextField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
  });

  final String label;
  final String value;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;

  @override
  State<RecipeFormTextField> createState() => _RecipeFormTextFieldState();
}

class _RecipeFormTextFieldState extends State<RecipeFormTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = widget.value;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // key: EditRecipeScreen.recipeNameKey,
      focusNode: widget.focusNode,
      controller: _controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.label.hardcoded,
        // enabled: true,
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
      autovalidateMode: widget.validator == null
          ? AutovalidateMode.disabled
          : AutovalidateMode.onUserInteraction,
    );
  }
}
