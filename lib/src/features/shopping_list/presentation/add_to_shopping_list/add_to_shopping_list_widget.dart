import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/shopping_list/presentation/shopping_list/shopping_list_screen_controller.dart';

class AddToShoppingListWidget extends ConsumerStatefulWidget {
  const AddToShoppingListWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShoppingListNewIngredientFormState();
}

class _ShoppingListNewIngredientFormState
    extends ConsumerState<AddToShoppingListWidget> with WidgetsBindingObserver {
  final _ingredientController = TextEditingController();

  final _ingredientFocus = FocusNode();
  final _form = GlobalKey<FormState>();

  /// Determine whether the keyboard is closing.
  Future<bool> get keyboardClosing async {
    final isAlreadyClosed =
        WidgetsBinding.instance.window.viewInsets.bottom == 0;

    final isClosing = WidgetsBinding.instance.window.viewInsets.bottom >
        await Future.delayed(
          const Duration(milliseconds: 50),
          () => WidgetsBinding.instance.window.viewInsets.bottom,
        );

    return isAlreadyClosed || isClosing;
  }

  /// If the form is valid, submit it and add the ingredient to the shopping list.
  /// If the form is not valid, display an error message.
  void _submitForm() async {
    final isValid = _form.currentState!.validate();
    final ingredientName = _ingredientController.value.text;

    _ingredientController.clear();
    _ingredientFocus.requestFocus();

    if (!isValid) {
      return;
    }

    ref
        .read(shoppingListScreenControllerProvider2.notifier)
        .addIngredient(ingredientName);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _ingredientController.dispose();
    _ingredientFocus.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // When the window insets changes, the method will be called by the system, where we can judge whether the keyboard is closing.
    // If the keyboard is closing, unfocus to end editing
    keyboardClosing.then((value) => value ? _ingredientFocus.unfocus() : null);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: Form(
        key: _form,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: _ingredientController,
                focusNode: _ingredientFocus,
                onFieldSubmitted: (value) => _submitForm(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter an ingredient";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'New ingredient',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: Sizes.p32,
              tooltip: "Add a ingredient to the shopping list",
              // color: Colors.amber,
              onPressed: () => _submitForm(),
            ),
          ],
        ),
      ),
    );
  }
}
