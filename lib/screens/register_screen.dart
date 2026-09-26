/// @title RegisterScreen
/// @notice Registration landing screen (Kosply slicing).
/// @dev Layout is UNCHANGED from the approved design: top logo, centered
/// illustration + typography, bottom-pinned auth buttons. The middle area
/// uses {CustomScrollView} + slivers (advanced layout) rendering the exact
/// same visuals. Login status is read from {AuthController} via Provider so
/// a sign-in on LoginScreen reflects here instantly.
/// @author Kosply slicing-ui
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';
import 'login_screen.dart';

/// @title RegisterScreen
/// @notice Registration landing screen widget.
/// @dev Stateless; shared state comes from {AuthController} (global),
/// navigation uses {Navigator}.
class RegisterScreen extends StatelessWidget {
  /// @notice Creates the register screen.
  /// @param key Optional widget key.
  /// @return A new {RegisterScreen} instance.
  const RegisterScreen({super.key});

  /// @dev Brand color, kept identical to the approved design.
  static const primary = Color(0xFF4F46E5);

  /// @notice Opens the email login form.
  /// @dev Pushes {LoginScreen} without changing any visual.
  /// @param context The build context.
  void _openLogin(BuildContext context) {
    debugPrint('Login tapped -> push LoginScreen');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  /// @notice Builds the register screen.
  /// @dev Top logo fixed, middle centered via slivers, bottom buttons pinned.
  /// @param context The build context.
  /// @return The register {Scaffold}.
  @override
  Widget build(BuildContext context) {
    // @dev Global state: rebuilds only this subtree when auth changes.
    final auth = context.watch<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: AssetImage('assets/images/kosply_logo.png'),
                  width: 110,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // @dev Advanced layout: CustomScrollView + slivers render the
            // same centered visuals (illustration, gap 10, logo, subtitle).
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage(
                                'assets/images/register_illustration.png',
                              ),
                              height: 260,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 10),
                            Image(
                              image: AssetImage(
                                'assets/images/kosply_logo.png',
                              ),
                              width: 140,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'E-commerce barang secondhand\nbagi mahasiswa',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SocialButton(
                    label: 'Login with Google',
                    asset: 'assets/images/google_icon.png',
                    onTap: () =>
                        context.read<AuthController>().socialLogin('google'),
                  ),
                  const SizedBox(height: 12),
                  _SocialButton(
                    label: 'Login with Apple',
                    asset: 'assets/images/apple_icon.png',
                    onTap: () =>
                        context.read<AuthController>().socialLogin('apple'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'or',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => _openLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/kosply_icon.png'),
                            width: 22,
                            height: 22,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Daftar with Email',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // @dev Same row position/style; text swaps with auth state
                  // so the LoginScreen sign-in reflects here instantly.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!auth.isLoggedIn) ...[
                        const Text(
                          'Sudah punya account? ',
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () => _openLogin(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ] else ...[
                        Flexible(
                          child: Text(
                            'Signed in as ${auth.user!.email}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.read<AuthController>().logout(),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// @title _SocialButton
/// @notice Outlined social sign-in button with grey border.
/// @dev Visual kept identical: white card, grey border, radius 12, height 52.
class _SocialButton extends StatelessWidget {
  /// @notice Creates a social button.
  /// @param label Button text.
  /// @param asset Icon asset path.
  /// @param onTap Tap callback.
  /// @return A new {_SocialButton} instance.
  const _SocialButton({
    required this.label,
    required this.asset,
    required this.onTap,
  });

  /// @dev Button text.
  final String label;

  /// @dev Icon asset path.
  final String asset;

  /// @dev Tap callback.
  final VoidCallback onTap;

  /// @notice Builds the outlined social button.
  /// @param context The build context.
  /// @return The outlined button widget.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(asset),
              width: 22,
              height: 22,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
