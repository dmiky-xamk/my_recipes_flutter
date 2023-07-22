import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/features/recipes/domain/directions.dart';
import 'package:my_recipes/src/localization/string_hardcoded.dart';

class RecipeDirectionsSection extends StatelessWidget {
  const RecipeDirectionsSection({super.key, required this.directions});

  final List<Direction> directions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Directions".hardcoded,
            style: Theme.of(context).textTheme.titleLarge),
        gapH8,
        for (var direction in directions)
          Row(
            children: [
              const Text(
                "\u2022",
                style: TextStyle(
                  fontSize: Sizes.p20,
                ),
              ),
              gapW8,
              Flexible(
                child: Text(
                  direction.step,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
