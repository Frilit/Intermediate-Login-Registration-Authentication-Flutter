import 'package:flutter/material.dart';
import 'package:login_registration_app/resuable_widgets/background.dart'; // import reusable layout
import 'package:login_registration_app/themes/theme_controller.dart';
import 'sign_up.dart';
import 'log_in.dart';

var logo = Container(
  alignment: Alignment.center,
  margin: const EdgeInsets.symmetric(horizontal: 24),
  child: Image.asset(
    'assets/images/FillerPic.png',
    width: double.infinity,
    height: 220,
    fit: BoxFit.contain,
  ),
);

Widget greetingText(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return Center(
    child: Text(
      "Welcome to My Application!",
      style: TextStyle(
        fontFamily: 'Poppins',
        color: colorScheme.onSurface,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

// Login Button Variable
Widget loginButton(BuildContext context, ThemeController themeController) {
  return Container(
    width: 350,
    height: 64,
    margin: const EdgeInsets.only(top: 40), // margin above the button for space
    child: ElevatedButton( // shadow or raised appearance
      onPressed: () {
        // Added context.mounted check and removed const for proper navigation
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogInScreen(key: UniqueKey(), themeController: themeController)),
          );
        }
      },
      style: ElevatedButton.styleFrom(),
      child: const Text(
        "Login",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

// Sign Up Button Function
Widget signupButton(BuildContext context, ThemeController themeController) {
  return Container(
    width: 350,
    height: 64,
    margin: const EdgeInsets.only(top: 15),
    child: ElevatedButton( // button with shadow or raised appearance
      onPressed: () {
        // Added context.mounted and removed const to avoid const
        if (context.mounted) {
          // Navigate to the Sign Up Screen when pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen(key: UniqueKey(), themeController: themeController)),
          );
        }
      },
      style: ElevatedButton.styleFrom(),
      child: const Text(
        "Sign Up",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}


class WelcomeScreen extends StatelessWidget {
  final ThemeController themeController; // for toggling theme in the flow
  const WelcomeScreen({super.key, required this.themeController});

  // This widget will be used under main.dart
  // It will be called there to display the contents of welcome_screen.dart as
  // WelcomeScreen() bc it is the class name

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BackgroundLayout( // uses reusable background
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min, // grouped in the center
              children: [
                const SizedBox(height: 16),
                logo,
                const SizedBox(height: 12),
                greetingText(context),
                const SizedBox(height: 16),
                Text(
                  "Sign in to continue or create a new account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                loginButton(context, themeController),
                signupButton(context, themeController),
                const SizedBox(height: 20),
                // theme toggle
                OutlinedButton.icon(
                  onPressed: () => themeController.toggle(),
                  icon: Icon(
                    Icons.brightness_6,
                    color: colorScheme.primary,
                  ),
                  label: const Text(
                    'Toggle Light/Dark',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
