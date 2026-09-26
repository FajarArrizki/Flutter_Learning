/// @title LoginScreen
/// @notice Email login form screen (Kosply slicing).
/// @dev Layout is UNCHANGED from the approved design: top-bar logo, gap 20,
/// "Selamat datang", card inputs with bottom-only border, "Lupa password? /
/// Ganti sekarang" row, bottom-pinned Back + Login buttons. State split:
/// global auth state via {AuthController} (Provider), local password
/// visibility via setState.
/// @author Kosply slicing-ui
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/auth_controller.dart';

/// @title LoginScreen
/// @notice Email login form widget.
/// @dev Stateful only for the local password-visibility toggle; shared
/// login status lives in {AuthController}.
class LoginScreen extends StatefulWidget {
  /// @notice Creates the login screen.
  /// @param key Optional widget key.
  /// @return A new {LoginScreen} instance.
  const LoginScreen({super.key});

  /// @dev Brand color, kept identical to the approved design.
  static const primary = Color(0xFF4F46E5);

  /// @notice Creates the mutable state.
  /// @return The {_LoginScreenState} instance.
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// @title _LoginScreenState
/// @notice Mutable state for {LoginScreen}.
/// @dev Holds ONLY local UI state (password visibility). Auth data is
/// global in {AuthController}.
class _LoginScreenState extends State<LoginScreen> {
  /// @dev Local UI state: whether the password field is obscured.
  bool _obscurePassword = true;

  /// @notice Toggles password visibility.
  /// @dev Local state via setState; global auth state is untouched.
  void _toggleVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  /// @notice Submits the login form.
  /// @dev Reads {AuthController} (global). On success pops back to
  /// Register, which reflects the new status instantly. On failure shows
  /// a transient SnackBar; layout stays unchanged.
  /// @param context The build context.
  void _submit(BuildContext context) {
    final auth = context.read<AuthController>();
    final ok = auth.login();
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(auth.error ?? 'Login failed')),
      );
    }
  }

  /// @notice Builds the login screen.
  /// @dev Top content scrolls, Back/Login row stays pinned at the bottom.
  /// @param context The build context.
  /// @return The login {Scaffold}.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Image(
          image: AssetImage('assets/images/kosply_logo.png'),
          width: 110,
          fit: BoxFit.contain,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Selamat datang',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _AuthInput(
                      hint: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (v) =>
                          context.read<AuthController>().setEmail(v),
                    ),
                    const SizedBox(height: 12),
                    _AuthInput(
                      hint: 'Password',
                      obscure: _obscurePassword,
                      onChanged: (v) =>
                          context.read<AuthController>().setPassword(v),
                      suffix: IconButton(
                        onPressed: _toggleVisibility,
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lupa password?',
                          style: TextStyle(color: Colors.black54),
                        ),
                        Text(
                          'Ganti sekarang',
                          style: TextStyle(
                            color: LoginScreen.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () => _submit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LoginScreen.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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

/// @title _AuthInput
/// @notice Card-style input with bottom-only border.
/// @dev Visual kept identical: grey card, bottom border only, radius 12.
class _AuthInput extends StatelessWidget {
  /// @notice Creates an auth input field.
  /// @param hint Placeholder text.
  /// @param obscure Whether text is obscured.
  /// @param keyboardType Optional keyboard type.
  /// @param onChanged Optional change callback (feeds global state).
  /// @param suffix Optional trailing widget (visibility toggle).
  /// @return A new {_AuthInput} instance.
  const _AuthInput({
    required this.hint,
    this.obscure = false,
    this.keyboardType,
    this.onChanged,
    this.suffix,
  });

  /// @dev Placeholder text.
  final String hint;

  /// @dev Whether the text is obscured.
  final bool obscure;

  /// @dev Optional keyboard type.
  final TextInputType? keyboardType;

  /// @dev Optional change callback.
  final ValueChanged<String>? onChanged;

  /// @dev Optional trailing widget.
  final Widget? suffix;

  /// @notice Builds the card input.
  /// @param context The build context.
  /// @return The input container widget.
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: TextField(
        obscureText: obscure,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: suffix,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
