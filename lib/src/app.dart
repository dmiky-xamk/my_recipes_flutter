import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_recipes/src/constants/app_themes.dart';
import 'package:my_recipes/src/features/authentication/data/auth_repository.dart';
import 'package:my_recipes/src/routing/app_router.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final currentUser = ref.watch(fetchPersistedUserProvider);
    debugPrint('Main currentUser: $currentUser');

    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: true,
      restorationScopeId: 'app',

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      theme: lightTheme,
      darkTheme: ThemeData.dark(),
      // themeMode: settingsController.themeMode,
      themeMode: ThemeMode.light,
    );
  }
}
