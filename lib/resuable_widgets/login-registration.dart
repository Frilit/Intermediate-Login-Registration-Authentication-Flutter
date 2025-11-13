import 'package:flutter/material.dart';

class loginRegistration extends StatelessWidget {
  final Widget child; // the foreground widget (signup/login form)
  const loginRegistration({super.key, required this.child});

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
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );

    return Stack(
      children: [
        // Custom background without image
        Container(decoration: background),
        Positioned(
          top: -50,
          left: -40,
          child: _softBlob(220, colorScheme.primary.withOpacity(0.08)),
        ),
        Positioned(
          bottom: -70,
          right: -30,
          child: _softBlob(260, colorScheme.tertiary.withOpacity(0.08)),
        ),

        // Foreground contents
        SafeArea(child: child),
      ],
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
            blurRadius: 36,
            spreadRadius: 12,
          ),
        ],
      ),
    );
  }
}
