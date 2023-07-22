import 'package:flutter/material.dart';

SnackBar floatingSnackBar(String contentText) => SnackBar(
      elevation: 2.0,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      content: Text(contentText),
    );
