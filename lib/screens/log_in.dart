import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Import to navigate back to WelcomeScreen
import 'package:login_registration_app/resuable_widgets/login-registration.dart';
import 'sign_up.dart'; // for navigation to Sign Up page

// Title Text
var loginTitleText = const Center(
  child: Text(
    "Login",
    style: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);

// Email Text Field
var loginEmailField = TextField(
  decoration: InputDecoration(
    labelText: "Email",
    labelStyle: const TextStyle(fontFamily: 'Poppins'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    prefixIcon: const Icon(Icons.email),
  ),
);

// Password Text Field
var loginPasswordField = TextField(
  obscureText: true,
  decoration: InputDecoration(
    labelText: "Password",
    labelStyle: const TextStyle(fontFamily: 'Poppins'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    prefixIcon: const Icon(Icons.lock),
  ),
);

// Login Button Widget
Widget loginButton(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 60,
    margin: const EdgeInsets.only(top: 10),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD1B48C),
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
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// Login Screen Widget
class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Includes a Bar on Top of the phone, below is the background image
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: loginRegistration(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white, // white box
                borderRadius: BorderRadius.circular(30), // rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  loginTitleText,
                  const SizedBox(height: 25),
                  loginEmailField,
                  const SizedBox(height: 20),
                  loginPasswordField,
                  const SizedBox(height: 25),
                  loginButton(context),

                  // Optional: Navigation to Sign Up screen
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
