import 'package:flutter/material.dart';

class IconSecondaryButton extends StatelessWidget {
  const IconSecondaryButton({
    super.key,
    required this.text,
    this.isLoading = false,
    required this.icon,
    this.onPressed,
  });
  final String text;
  final bool isLoading;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabledColor = Theme.of(context).primaryColor;
    const disabledColor = Colors.grey;

    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isLoading ? disabledColor : enabledColor,
        ),
      ),
      icon: Icon(
        icon,
        color: isLoading ? disabledColor : enabledColor,
      ),
      label: Text(
        text,
        style: TextStyle(
          color: isLoading ? disabledColor : enabledColor,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
