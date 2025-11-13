import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Import to navigate back to WelcomeScreen
import 'package:login_registration_app/resuable_widgets/login-registration.dart'; // import reusable layout
import 'log_in.dart';
import 'package:shared_preferences/shared_preferences.dart'; // shared preference package for local storage
import 'package:login_registration_app/themes/theme_controller.dart';


class SignUpScreen extends StatefulWidget {
  final ThemeController themeController; // for theme toggling
  const SignUpScreen({super.key, required this.themeController});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>(); // For form validation. It allows changes

  // Controllers to retrieve field values
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscure = true;
  bool _obscureConfirm = true;

  Widget titleText(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Text(
        "Sign Up",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget fullNameField() {
    return TextFormField(
      controller: _fullNameController,
      decoration: InputDecoration(
        labelText: "Full Name",
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your full name";
        }
        return null;
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your email";
        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
    );
  }


  Widget passwordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: "Password",
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        } else if (value.length < 5) {
          return "Password must be at least 5 characters";
        }
        return null;
      },
    );
  }

  Widget confirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirm,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        labelStyle: const TextStyle(fontFamily: 'Poppins'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
          icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please confirm your password";
        }
        if (value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }

  Widget signUpButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // Save the data locally
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('fullName', _fullNameController.text); // prefs as local storages for the device
            await prefs.setString('email', _emailController.text);
            await prefs.setString('password', _passwordController.text);

            // Navigate to Login screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LogInScreen(themeController: widget.themeController)),
            );
          }
        },
        // Use themed button to ensure proper contrast
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

  @override // this prevents memory leakage after each operation (good practice)
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen(themeController: widget.themeController)),
            );
          },
        ),
        actions: [
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () => widget.themeController.toggle(),
            icon: const Icon(Icons.brightness_6),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: loginRegistration(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),


              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                      titleText(context),
                    const SizedBox(height: 25),
                    fullNameField(),
                    const SizedBox(height: 20),
                    emailField(),
                    const SizedBox(height: 20),
                    passwordField(),
                    const SizedBox(height: 20),
                    confirmPasswordField(),
                    const SizedBox(height: 30),
                    signUpButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
