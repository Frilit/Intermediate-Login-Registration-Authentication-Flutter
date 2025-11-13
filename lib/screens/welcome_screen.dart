import 'package:flutter/material.dart';
import 'package:login_registration_app/resuable_widgets/background.dart'; // import reusable layout
import 'sign_up.dart';
import 'log_in.dart';

var logo = Container(
  alignment: Alignment.center,
  margin: const EdgeInsets.only(left: 20, right: 20),
  child: Image.asset(
    'assets/images/FillerPic.png',
    width: double.infinity,
    height: 400,
    fit: BoxFit.cover,
  ),
);

var greetingText = const Center(
  child: Text(
    "Welcome to My Application!",
    style: TextStyle(
      fontFamily: 'Poppins',
      color: Colors.white,
      fontSize: 40,
      fontWeight: FontWeight.w600,
    ),
    textAlign: TextAlign.center,
  ),
);

// Login Button Variable
Widget loginButton(BuildContext context) {
  return Container(
    width: 350,
    height: 70,
    margin: const EdgeInsets.only(top: 90), // margin above the button for space
    child: ElevatedButton( // shadow or raised appearance
      onPressed: () {
        // ✅ Added context.mounted check and removed const for proper navigation
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogInScreen(key: UniqueKey())),
          );
        }
      },
      style: ElevatedButton
          .styleFrom( // customize the visual style of a Material button
        backgroundColor: const Color(0xFFD1B48C), // light brown color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
      child: const Text(
        "Login",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// Sign Up Button Function
Widget signupButton(BuildContext context) {
  return Container(
    width: 350,
    height: 70,
    margin: const EdgeInsets.only(top: 15),
    child: ElevatedButton( // button with shadow or raised appearance
      onPressed: () {
        // Added context.mounted and removed const to avoid const
        if (context.mounted) {
          // Navigate to the Sign Up Screen when pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen(key: UniqueKey())),
          );
        }
      },
      style: ElevatedButton.styleFrom( // customize the visual style of a Material button
        backgroundColor: const Color(0xFFD1B48C), // light brown color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5, // adds a shadow effect for a raised appearance
      ),
      child: const Text(
        "Sign Up",
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // This widget will be used under main.dart
  // It will be called there to display the contents of welcome_screen.dart as
  // WelcomeScreen() bc it is the class name

  @override
  Widget build(BuildContext context) {
    return BackgroundLayout( // uses reusable background
      child: Column(
        mainAxisSize: MainAxisSize.min, // Makes sure widgets stay grouped together in the center instead of being stretched vertically across the screen.
        children: [
          logo,
          greetingText,
          loginButton(context),
          signupButton(context),
        ],
      ),
    );
  }
}
