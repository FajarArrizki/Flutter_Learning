/// @title AuthController unit tests
/// @notice Verifies global login state in isolation from the UI.
/// @author Kosply slicing-ui
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:getting_started_flutter/controllers/auth_controller.dart';

/// @notice AuthController unit test suite.
/// @dev Covers initial state, validation, login, social login and logout.
/// @return void
void main() {
  /// @dev Fresh controller per test.
  late AuthController auth;

  setUp(() {
    auth = AuthController();
  });

  test('Initial state is signed out', () {
    expect(auth.isLoggedIn, isFalse);
    expect(auth.user, isNull);
    expect(auth.error, isNull);
  });

  test('Invalid login fills error', () {
    final ok = auth.login(email: 'not-an-email');
    expect(ok, isFalse);
    expect(auth.isLoggedIn, isFalse);
    expect(auth.error, isNotNull);
  });

  test('Valid login signs the user in', () {
    auth.setEmail('mhs@kampus.ac.id');
    auth.setPassword('1234');
    final ok = auth.login();
    expect(ok, isTrue);
    expect(auth.isLoggedIn, isTrue);
    expect(auth.user!.email, 'mhs@kampus.ac.id');
  });

  test('Social login broadcasts instantly', () {
    auth.socialLogin('google');
    expect(auth.isLoggedIn, isTrue);
    expect(auth.user!.email, contains('google'));
  });

  test('Logout clears the session', () {
    auth.socialLogin('apple');
    auth.logout();
    expect(auth.isLoggedIn, isFalse);
    expect(auth.user, isNull);
  });
}
