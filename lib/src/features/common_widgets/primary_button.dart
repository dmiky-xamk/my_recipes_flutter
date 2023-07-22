import 'package:flutter/material.dart';
import 'package:my_recipes/src/constants/app_themes.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    this.loadingText = "Loading...",
    this.isLoading = false,
    this.onPressed,
  });

  final String text;
  final String loadingText;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll<double>(2.0),
        backgroundColor: MaterialStatePropertyAll<Color>(
          isLoading ? const Color(0xffA5A5A5) : Theme.of(context).primaryColor,
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? Text(
              loadingText,
              style: Theme.of(context).textTheme.titleMediumBolded.copyWith(
                    color: Colors.white,
                  ),
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMediumBolded.copyWith(
                    color: Colors.white,
                  ),
            ),
    );
  }
}
