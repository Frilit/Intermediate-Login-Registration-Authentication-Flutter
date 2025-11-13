import 'package:flutter/material.dart';
import 'package:login_registration_app/themes/theme_controller.dart';
import 'welcome_screen.dart'; // Import your Welcome Screen

class SplashScreen extends StatefulWidget { // Use Stateful Widget because splash screen needs animations and timed navigation, which both rely on state changes.
  final ThemeController themeController; // allow theme toggling later in the flow
  const SplashScreen({super.key, required this.themeController});

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
    Future.delayed(const Duration(milliseconds: 2200), () {
      // FIX: Added a check to ensure the widget is still on screen before navigating.
      if (mounted) {
        Navigator.of(context).pushReplacement(_createFadeRoute());
      }
    });
  }

  // Custom page transition using PageRouteBuilder.
  Route _createFadeRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) =>
          WelcomeScreen(themeController: widget.themeController),
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
    // Use a dynamic-looking radial + linear combo for a modern, clean splash without images
    gradient: LinearGradient(
      colors: [Color(0xFFEFF2FF), Color(0xFFFFFFFF)],
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
      color: Color(0xFF1F2343),
      fontSize: 38,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
    textAlign: TextAlign.center,
  );

  final Widget tagline = const Text(
    "Your journey begins here ✨\nLet’s make something amazing.",
    style: TextStyle(
      fontFamily: 'Poppins',
      color: Color(0xFF4B5563),
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
        color: Color(0xFF4F46E5),
        strokeWidth: 3,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundGradient,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // soft decorative circles
            Positioned(
              top: -60,
              left: -40,
              child: _decorativeCircle(160, const Color(0xFFDBEAFE)),
            ),
            Positioned(
              bottom: -50,
              right: -30,
              child: _decorativeCircle(200, const Color(0xFFE9D5FF)),
            ),
            Center(
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
          ],
        ),
      ),
    );
  }

  // decorative helper for background shapes
  Widget _decorativeCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
    );
  }
}
