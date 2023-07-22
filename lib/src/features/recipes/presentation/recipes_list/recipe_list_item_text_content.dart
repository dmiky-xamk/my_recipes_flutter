import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';
import 'package:my_recipes/src/constants/app_themes.dart';

class RecipeListItemTextContent extends StatelessWidget {
  const RecipeListItemTextContent(
      {super.key, required this.name, required this.description});

  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleMediumBolded,
        ),
        gapH8,
        Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
