import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Import your Welcome Screen

class SplashScreen extends StatefulWidget { // Use Stateful Widget because splash screen needs animations and timed navigation, which both rely on state changes.
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin { // use only one animation controller.

  // variables for animation control (self explanatory names)
  late AnimationController _controller; // controls when and how fast animations play.
  late Animation<double> _fadeAnimation; // fade in and fade out
  late Animation<double> _scaleAnimation; // size changes (zoom in and zoom out)

  @override
  void initState() {
    super.initState();

    // Animation controller for fade & scale
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutQuart, // easeInOutQuart curve to make the opacity transition smooth and gradual.
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.05).animate( // logo “grow” slightly when appearing
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward(); // starts the animation

    // Navigate to WelcomeScreen with a smooth fade transition
    Future.delayed(const Duration(milliseconds: 3500), () {
      // FIX: Added a check to ensure the widget is still on screen before navigating.
      if (mounted) {
        Navigator.of(context).pushReplacement(_createFadeRoute());
      }
    });
  }

  // Custom page transition using PageRouteBuilder.
  Route _createFadeRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1200),
      pageBuilder: (context, animation, secondaryAnimation) =>
      const WelcomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() { // release animation resources to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  final BoxDecoration backgroundGradient = const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFFCAF0F8), // Pale sky blue
        Color(0xFF90E0EF), // Soft cyan blue
        Color(0xFF48CAE4), // Light teal-blue
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  final Widget logo = Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(bottom: 25),
    child: Image.asset(
      'assets/images/FillerPic.png',
      width: 180,
      height: 180,
      fit: BoxFit.contain,
    ),
  );

  final Widget appTitle = const Text(
    "Welcome!",
    style: TextStyle(
      fontFamily: 'Poppins',
      color: Color(0xFF023E8A),
      fontSize: 40,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
      shadows: [
        Shadow(
          color: Colors.black26,
          offset: Offset(2, 2),
          blurRadius: 4,
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );

  final Widget tagline = const Text(
    "Your journey begins here ✨\nLet’s make something amazing.",
    style: TextStyle(
      fontFamily: 'Poppins',
      color: Color(0xFF1E6091),
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w500,
    ),
    textAlign: TextAlign.center,
  );

  final Widget loadingIndicator = const Padding(
    padding: EdgeInsets.only(top: 40),
    child: SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        color: Color(0xFF0077B6),
        strokeWidth: 3,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundGradient,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  logo,
                  appTitle,
                  const SizedBox(height: 15),
                  tagline,
                  loadingIndicator,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
