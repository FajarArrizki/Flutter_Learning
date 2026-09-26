/// @title SplashScreen
/// @notice Brand splash screen (Kosply slicing).
/// @dev Layout is UNCHANGED from the approved design: centered icon, gap 10,
/// typography. A basic entry animation (fade + scale, 800ms) plays on load
/// to meet the basic-animation learning goal. After 2 seconds it replaces
/// itself with {RegisterScreen}.
/// @author Kosply slicing-ui
library;

import 'package:flutter/material.dart';

import 'register_screen.dart';

/// @title SplashScreen
/// @notice Brand splash screen widget.
/// @dev Stateful to run the entry animation and the delayed navigation timer.
class SplashScreen extends StatefulWidget {
  /// @notice Creates the splash screen.
  /// @param key Optional widget key.
  /// @return A new {SplashScreen} instance.
  const SplashScreen({super.key});

  /// @notice Creates the mutable state.
  /// @return The {_SplashScreenState} instance.
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// @title _SplashScreenState
/// @notice Mutable state for {SplashScreen}.
/// @dev Drives the fade/scale entry animation and the 2-second navigation.
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  /// @dev Controls the 800ms entry animation.
  late final AnimationController _controller;

  /// @dev Fade from transparent to opaque.
  late final Animation<double> _fade;

  /// @dev Scale from 95% to 100%.
  late final Animation<double> _scale;

  /// @notice Starts the entry animation and the splash delay timer.
  /// @dev Uses {Future.delayed}; guards with {mounted} before navigating.
  /// @return void
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
    });
  }

  /// @notice Releases the animation controller.
  /// @return void
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// @notice Builds the centered logo composition with entry animation.
  /// @dev Icon 96x96, gap 10, logo width 160 — identical to the design.
  /// @param context The build context.
  /// @return The splash {Scaffold}.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _AnimatedLogo(),
      ),
    );
  }
}

/// @title _AnimatedLogo
/// @notice Logo composition wrapped in the entry animation.
/// @dev Split out so the animated subtree rebuilds without touching
/// the static {Scaffold}. Sizes match the approved design.
class _AnimatedLogo extends StatelessWidget {
  /// @notice Creates the animated logo.
  /// @return A new {_AnimatedLogo} instance.
  const _AnimatedLogo();

  /// @notice Builds the fade + scale logo composition.
  /// @dev Reads the parent state's controller via context ancestry.
  /// @param context The build context.
  /// @return The animated logo widget.
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_SplashScreenState>()!;
    return FadeTransition(
      key: const ValueKey('splashFade'),
      opacity: state._fade,
      child: ScaleTransition(
        key: const ValueKey('splashScale'),
        scale: state._scale,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage('assets/images/kosply_icon.png'),
              width: 96,
              height: 96,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            Image(
              image: AssetImage('assets/images/kosply_logo.png'),
              width: 160,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
