import 'package:flutter/material.dart';

/// This widget creates a reusable background layout that can be used across multiple pages.
/// It uses a Stack to layer a modern, image-free gradient with soft shapes behind any given child content.
class BackgroundLayout extends StatelessWidget {
  final Widget child; // the content to display on top of the background

  const BackgroundLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // --- variables/widgets first ---
    final colorScheme = Theme.of(context).colorScheme;
    final BoxDecoration background = BoxDecoration(
      gradient: LinearGradient(
        colors: [
          colorScheme.surface,
          colorScheme.surfaceContainerHighest.withOpacity(0.6),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );

    return Scaffold(
      appBar: AppBar( // Includes a Bar on Top of the phone
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack( // stack() used for background to be able to place widgets on top of each other
        children: [
          // Decorative background without using an image
          Container(decoration: background),
          Positioned(
            top: -40,
            right: -30,
            child: _softBlob(180, colorScheme.primary.withOpacity(0.10)),
          ),
          Positioned(
            bottom: -60,
            left: -20,
            child: _softBlob(220, colorScheme.secondary.withOpacity(0.10)),
          ),
          SafeArea(
            child: child, // display whatever widget is passed into this layout
          ),
        ],
      ),
    );
  }

  // helper for soft circular blob
  Widget _softBlob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }
}
