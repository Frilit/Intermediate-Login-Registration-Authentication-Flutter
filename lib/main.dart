import 'package:flutter/material.dart';
import 'package:login_registration_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // removes the "DEBUG" banner on the top right of the phone
      title: 'Login and Registration App', // just to describe the application
      home: const SplashScreen(),
    );
  } // end tag for widget build
} // end tag for class MyApp
