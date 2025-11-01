import 'package:flutter/material.dart';

/// This widget creates a reusable background layout that can be used across multiple pages.
/// It uses a Stack to layer the background image behind any given child content.
class BackgroundLayout extends StatelessWidget {
  final Widget child; // the content to display on top of the background image

  const BackgroundLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Includes a Bar on Top of the phone, below is the background image
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack( // stack() used for background to be able to place widgets on top of each other
        children: [
          Transform.scale(
            scale: 1.5, // increase to make background appear closer
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover, // Scale the image to completely cover the box
              width: double.infinity, // expand to fill all the available horizontal space
              height: double.infinity, // fill all the available vertical space in its parent.
            ),
          ),
          SafeArea(
            child: child, // display whatever widget is passed into this layout
          ),
        ],
      ),
    );
  }
}
