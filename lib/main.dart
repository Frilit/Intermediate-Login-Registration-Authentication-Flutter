import 'package:flutter/material.dart';
import 'package:login_registration_app/screens/splash_screen.dart';
import 'package:login_registration_app/themes/app_theme.dart';
import 'package:login_registration_app/themes/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // --- variables/widgets first ---
    final ThemeController themeController = ThemeController(); // controller for theme mode (light/dark)

    // Use FutureBuilder so the saved ThemeMode (if any) is loaded before showing the app
    return FutureBuilder<void>(
      future: themeController.load(),
      builder: (context, snapshot) {
        return AnimatedBuilder(
          animation: themeController,
          builder: (context, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false, // removes the "DEBUG" banner on the top right of the phone
              title: 'Login and Registration App', // just to describe the application
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: themeController.mode,
              home: SplashScreen(
                // pass controller down so screens can toggle theme
                themeController: themeController,
              ),
            );
          },
        );
      },
    );
  } // end tag for widget build
} // end tag for class MyApp
