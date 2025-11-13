import 'package:flutter/material.dart';
import 'dart:ui' as ui; // for blur filter
import 'package:login_registration_app/resuable_widgets/background.dart'; // import your reusable layout
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_registration_app/themes/theme_controller.dart';
import 'package:intl/intl.dart';
class HomeScreen extends StatefulWidget {
  final ThemeController? themeController; // optional injection to allow toggling theme
  const HomeScreen({super.key, this.themeController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // variables first
  String _displayName = '';
  bool _isHidden = false; // whether balance is hidden
  late final AnimationController _blurController; // controls blur animation
  late final AnimationController _shimmerController; // controls gradient shimmer sweep
  bool _showShimmer = true; // show shimmer briefly on first load

  @override
  void initState() {
    super.initState();
    _loadName();
    // blur controller: 0 -> visible, 1 -> fully blurred
    _blurController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 0.0,
    );
    // shimmer controller repeats while _showShimmer is true
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    // stop shimmer after a short delay
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() {
          _showShimmer = false;
        });
        _shimmerController.stop();
      }
    });
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _displayName = prefs.getString('fullName') ?? '';
    });
  }

  // quick-edit name sheet removed per request

  // helper: build an animated shimmer overlay using alignment tween from left to right
  Widget _shimmerSweep(Color base) {
    if (!_showShimmer) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        final t = _shimmerController.value; // 0..1
        // alignment.x from -1 to 1
        final alignX = -1.0 + 2.0 * t;
        return Align(
          alignment: Alignment(alignX, 0),
          child: FractionallySizedBox(
            widthFactor: 0.35,
            heightFactor: 1.2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    base.withOpacity(0.0),
                    Colors.white.withOpacity(0.28),
                    base.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggleHide() {
    setState(() {
      _isHidden = !_isHidden;
      if (_isHidden) {
        _blurController.forward();
      } else {
        _blurController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final amount = _formatPhp(34000.56);
    return BackgroundLayout(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: colorScheme.surface.withOpacity(0.60),
                borderRadius: BorderRadius.circular(25),
              ),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            child: Text(
                              (_displayName.isNotEmpty ? _displayName[0] : '?').toUpperCase(),
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "SSang Co. Bank",
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Toggle theme',
                            icon: const Icon(Icons.brightness_6),
                            color: colorScheme.onSurface,
                            onPressed: () => widget.themeController?.toggle(),
                          ),
                          IconButton(
                            icon: const Icon(Icons.logout),
                            color: colorScheme.onSurface,
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[colorScheme.primary, colorScheme.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _displayName.isNotEmpty ? "Welcome, $_displayName!" : "Welcome!",
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "My Account",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: AnimatedBuilder(
                                    animation: _blurController,
                                    builder: (BuildContext context, Widget? child) {
                                      final double sigma = 6.0 * _blurController.value;
                                      return ClipRect(
                                        child: ImageFiltered(
                                          imageFilter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                                          child: Text(
                                            amount,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 34,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamilyFallback: <String>['Roboto', 'Noto Sans', 'Segoe UI Symbol', 'Arial'],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: _toggleHide,
                                  color: Colors.white,
                                  icon: Icon(_isHidden ? Icons.visibility : Icons.visibility_off),
                                  tooltip: _isHidden ? 'Show balance' : 'Hide balance',
                                ),
                              ],
                            ),
                          ],
                        ),
                        Positioned.fill(child: _shimmerSweep(colorScheme.secondary)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildActionButton(Icons.account_balance_wallet, "Deposit", colorScheme),
                      _buildActionButton(Icons.send, "Transfer", colorScheme),
                      _buildActionButton(Icons.qr_code, "Scan QR", colorScheme),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildFeatureCard(Icons.receipt_long, "Pay Bills", colorScheme),
                      _buildFeatureCard(Icons.phone_android, "Buy Load", colorScheme),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.exit_to_app, color: colorScheme.onSurface),
                      label: Text(
                        "Exit",
                        style: TextStyle(color: colorScheme.onSurface),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _blurController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  Widget _buildActionButton(IconData icon, String label, ColorScheme colorScheme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(icon, size: 32, color: colorScheme.primary),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, ColorScheme colorScheme) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: colorScheme.onSurface, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

// helper: format PHP currency with peso sign
String _formatPhp(double value) {
  final f = NumberFormat.currency(locale: 'en_PH', symbol: '₱');
  return f.format(value);
}
