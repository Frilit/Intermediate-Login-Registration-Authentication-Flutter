import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Import to navigate back to WelcomeScreen
import 'package:login_registration_app/resuable_widgets/login-registration.dart'; // import your reusable layout
import 'log_in.dart';

var titleText = const Center(
  child: Text(
    "Sign Up",
    style: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);

var fullNameField = TextField(
  decoration: InputDecoration(
    labelText: "Full Name",
    labelStyle: const TextStyle(fontFamily: 'Poppins'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    prefixIcon: const Icon(Icons.person),
  ),
);

var emailField = TextField(
  decoration: InputDecoration(
    labelText: "Email",
    labelStyle: const TextStyle(fontFamily: 'Poppins'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    prefixIcon: const Icon(Icons.email),
  ),
);

var passwordField = TextField(
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

Widget signUpButton(BuildContext context) {
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
          "Sign Up",
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


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              // Use variable widgets here
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  titleText,
                  const SizedBox(height: 25),
                  fullNameField,
                  const SizedBox(height: 20),
                  emailField,
                  const SizedBox(height: 20),
                  passwordField,
                  const SizedBox(height: 30),
                  signUpButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
