import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';

class CenteredTextWidget extends StatelessWidget {
  const CenteredTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: Sizes.p20,
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
