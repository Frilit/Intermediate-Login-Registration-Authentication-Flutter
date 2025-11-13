import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Import to navigate back to WelcomeScreen
import 'package:login_registration_app/resuable_widgets/login-registration.dart';
import 'sign_up.dart'; // for navigation to Sign Up page
import 'package:shared_preferences/shared_preferences.dart'; // shared preference package for local storage
import 'home_screen.dart';
import 'package:login_registration_app/themes/theme_controller.dart';


class LogInScreen extends StatefulWidget {
  final ThemeController themeController; // for toggling from the AppBar action if needed
  const LogInScreen({super.key, required this.themeController});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>(); // For form validation
  // TextEditingControllers read the text typed into the email and password field
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscure = true; // toggle for password visibility

  Widget loginTitleText(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Text(
        "Login",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
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
        }
        else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
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
        }
        if (value.length < 5) {
          return "Password must be at least 5 characters";
        }
        return null;
      },
    );
  }

  Widget loginButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            SharedPreferences prefs = await SharedPreferences.getInstance();

            // Retrieve saved credentials
            String? savedEmail = prefs.getString('email');
            String? savedPassword = prefs.getString('password');

            // Check if entered credentials match
            if (_emailController.text == savedEmail &&
                _passwordController.text == savedPassword) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(themeController: widget.themeController)),
              );
            } else {
              // error message below
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Invalid email or password")),
              );
            }
          }
        },
        // Use theme-provided button colors for correct contrast in dark/light
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


  @override // this prevents memory leakage after each operation (good practice)
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                    loginTitleText(context),
                    const SizedBox(height: 25),
                    emailField(),
                    const SizedBox(height: 20),
                    passwordField(),
                    const SizedBox(height: 25),
                    loginButton(context),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen(themeController: widget.themeController)),
                        );
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          fontFamily: 'Poppins',
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
      ),
    );
  }
}
