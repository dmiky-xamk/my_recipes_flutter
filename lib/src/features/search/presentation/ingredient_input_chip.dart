import 'dart:developer';

import 'package:flutter/material.dart';

class IngredientInputChip extends StatefulWidget {
  const IngredientInputChip({
    super.key,
    required this.ingredientName,
    required this.onDelete,
    required this.lockedIngredients,
  });

  final String ingredientName;
  final VoidCallback onDelete;
  final Set<String> lockedIngredients;

  @override
  State<IngredientInputChip> createState() => _IngredientInputChipState();
}

class _IngredientInputChipState extends State<IngredientInputChip> {
  bool isLocked = false;

  @override
  Widget build(BuildContext context) {
    // final isSelected = widget.lockedIngredients.contains(widget.ingredientName);

    return InputChip(
      label: Text(
        widget.ingredientName,
      ),
      deleteIconColor: Colors.grey.shade500,
      onDeleted: widget.onDelete,
      avatar: Icon(
        isLocked ? Icons.lock : Icons.lock_open,
        color: Colors.grey.shade500,
      ),
      onSelected: (bool value) {
        log("isSelected: ${isLocked.toString()}");
        isLocked
            ? widget.lockedIngredients.remove(widget.ingredientName)
            : widget.lockedIngredients.add(
                widget.ingredientName,
              );
        setState(() {
          isLocked = !isLocked;
        });
      },
    );
  }
}
