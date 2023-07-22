import 'dart:typed_data';

import 'package:flutter/material.dart';

class RecipeImageContainer extends StatelessWidget {
  final Uint8List? recipeImage;
  final double width;
  final double height;
  final double borderRadius;

  const RecipeImageContainer({
    Key? key,
    required this.recipeImage,
    required this.width,
    required this.height,
    required this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 222, 222, 222),
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.network(
              "https://images.unsplash.com/flagged/photo-1557609786-fd36193db6e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80",
            ).image),
        // image: pickTileImage(recipeImage),
      ),
    );
  }

  DecorationImage? pickTileImage(Uint8List? recipeImage) {
    if (recipeImage == null) return null;

    return DecorationImage(
      fit: BoxFit.cover,
      image: MemoryImage(recipeImage),
    );
  }
}
