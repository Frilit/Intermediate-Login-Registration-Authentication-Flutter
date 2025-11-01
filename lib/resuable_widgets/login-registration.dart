import 'package:flutter/material.dart';

class loginRegistration extends StatelessWidget {
  final Widget child; // the foreground widget (your signup/login form)
  const loginRegistration({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Custom background image
        Transform.scale(
          scale: 1.5, // increase to make background appear closer
          child: Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover, // Scale the image to completely cover the box
            width: double.infinity, // expand to fill all the available horizontal space
            height: double.infinity, // fill all the available vertical space
          ),
        ),

        // Foreground contents
        SafeArea(child: child),
      ],
    );
  }
}
