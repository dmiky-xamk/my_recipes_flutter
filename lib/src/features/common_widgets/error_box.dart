import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_sizes.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      constraints: const BoxConstraints(
        minHeight: Sizes.p48,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(Sizes.p4),
        ),
      ),
      margin: const EdgeInsets.only(
        bottom: Sizes.p16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p8,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
          ),
          gapW8,
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
