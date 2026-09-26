/// @title SplashScreen
/// @notice Brand splash screen (Kosply slicing).
/// @dev Layout is UNCHANGED from the approved design: centered icon, gap 10,
/// typography. After 2 seconds it replaces itself with {RegisterScreen}.
/// @author Kosply slicing-ui
library;

import 'package:flutter/material.dart';

import 'register_screen.dart';

/// @title SplashScreen
/// @notice Brand splash screen widget.
/// @dev Stateful only to run the delayed navigation timer.
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
/// @dev Starts a 2-second timer, then navigates to {RegisterScreen}.
class _SplashScreenState extends State<SplashScreen> {
  /// @notice Starts the splash delay timer.
  /// @dev Uses {Future.delayed}; guards with {mounted} before navigating.
  /// @return void
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RegisterScreen()),
      );
    });
  }

  /// @notice Builds the centered logo composition.
  /// @dev Icon 96x96, gap 10, logo width 160 — identical to the design.
  /// @param context The build context.
  /// @return The splash {Scaffold}.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
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
