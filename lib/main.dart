import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/features/authentication/data/auth_repository.dart';
import 'package:my_recipes/src/features/shopping_list/data/shopping_list_repository.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

// TODO: Remove this when we have a proper certificate.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  // setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  HttpOverrides.global = MyHttpOverrides();

  // * Create async repository before the app initializes,
  // * so that we don't have to deal with 'AsyncValue' in the app.
  final shoppingListRepository = await ShoppingListRepository.createDefault();
  final authRepository = await AuthRepository.createDefault();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    ProviderScope(
      overrides: [
        shoppingListRepositoryProvider
            .overrideWithValue(shoppingListRepository),
        authRepositoryProvider.overrideWithValue(authRepository),
      ],
      child: MyApp(settingsController: settingsController),
    ),
  );
}
