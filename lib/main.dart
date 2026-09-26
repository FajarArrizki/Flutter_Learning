/// @title Kosply App Entry
/// @notice Application entry point with global state wiring.
/// @dev {AuthController} is provided inside {MyApp} (above {MaterialApp})
/// so Splash, Register and Login — including pushed routes — share one
/// login status instance via Provider. Keeping the provider inside {MyApp}
/// also keeps widget tests able to pump {MyApp} directly.
/// @author Kosply slicing-ui
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';
import 'screens/splash_screen.dart';

/// @notice Starts the Flutter application.
/// @dev Runs {MyApp}; global state is registered inside {MyApp.build}.
/// @return void
void main() {
  runApp(const MyApp());
}

/// @title MyApp
/// @notice Root widget of the Kosply app.
/// @dev Stateless; global state comes from Provider, local state
/// (e.g. password visibility) lives in each screen via setState.
class MyApp extends StatelessWidget {
  /// @notice Creates the root widget.
  /// @param key Optional widget key.
  /// @return A new {MyApp} instance.
  const MyApp({super.key});

  /// @notice Builds the app shell with global state.
  /// @dev Keeps the original design: white theme, Splash as home.
  /// @param context The build context.
  /// @return The provider-wrapped {MaterialApp}.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
