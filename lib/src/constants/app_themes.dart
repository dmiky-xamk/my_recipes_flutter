import 'package:flutter/material.dart';

// Used to indicate actions or interactive elements like links and buttons
const primaryColor = Color(0xffed6e06);

// Used for primary text, like headings, body content and labels
const darkest = Color(0xff1A1009);

// Used for secondary text to make it less prominent
const dark = Color(0xff606060);

// Used for non-decorative borders on interface elements like form input fields
const medium = Color(0xffA5A5A5);

// Used for decorative borders that aren't critical to identifying elements
// Decorative borders are often used to emphasize the separation between elements
// Removing them won't affect the usability of the interface
const light = Color(0xffE8E8E8);

// Used as an alternative background color from white to
// differentiate parts of an interface from the main white background
const lightest = Color(0xffF7F7F7);
const white = Color(0xffFFFFFF);

final ThemeData theme = ThemeData(fontFamily: "Lato");

final lightTheme = theme.copyWith(
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: primaryColor,
    selectionColor: primaryColor,
    selectionHandleColor: primaryColor,
  ),
  primaryColor: primaryColor,
  textTheme: ThemeData.light().textTheme.copyWith(
        // Can't bold this one, as it's used for 'TextField' input text
        titleMedium: const TextStyle(
          color: darkest,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: const TextStyle(
          color: dark,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: const TextStyle(
          color: dark,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
    ),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: primaryColor,
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: primaryColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: primaryColor,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusColor: primaryColor,
    floatingLabelStyle: TextStyle(color: primaryColor),
    border: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: medium),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: primaryColor, width: 2),
    ),
    labelStyle: TextStyle(
      // color: darkest,
      fontWeight: FontWeight.w400,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor),
  scaffoldBackgroundColor: lightest,
);

extension CustomStyles on TextTheme {
  TextStyle get titleMediumBolded => const TextStyle(
        color: darkest,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
}
