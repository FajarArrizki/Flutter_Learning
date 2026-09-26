/// @title Widget tests (Splash / Register / Login)
/// @notice Verifies the approved design and the splash > register > login
/// flow, including instant cross-screen auth reflection via Provider.
/// @author Kosply slicing-ui
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:getting_started_flutter/controllers/auth_controller.dart';
import 'package:getting_started_flutter/main.dart';
import 'package:getting_started_flutter/screens/login_screen.dart';
import 'package:getting_started_flutter/screens/register_screen.dart';
import 'package:getting_started_flutter/screens/splash_screen.dart';

/// @notice Pumps a screen wrapped with the global {AuthController}.
/// @dev Every screen reads Provider, so tests must provide it.
/// @param tester The widget tester.
/// @param child The screen under test.
/// @return Future completing after the first frame.
Future<void> pumpWithAuth(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    ChangeNotifierProvider(
      create: (_) => AuthController(),
      child: MaterialApp(home: child),
    ),
  );
}

/// @notice Widget test suite for the three slicing screens.
/// @dev Design assertions (texts, gaps, buttons) plus navigation and
/// global-state reflection coverage.
/// @return void
void main() {
  testWidgets('Splash screen renders icon, gap, and logo', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(Image), findsNWidgets(2));

    final sizedBox = tester.widget<SizedBox>(
      find.byWidgetPredicate((w) => w is SizedBox && w.height == 10),
    );
    expect(sizedBox.height, 10);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  });

  testWidgets('Splash navigates to Register after delay', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
  });

  testWidgets('Register renders illustration, texts, and buttons', (
    WidgetTester tester,
  ) async {
    await pumpWithAuth(tester, const RegisterScreen());

    expect(
      find.text('E-commerce barang secondhand\nbagi mahasiswa'),
      findsOneWidget,
    );
    expect(find.text('Login with Google'), findsOneWidget);
    expect(find.text('Login with Apple'), findsOneWidget);
    expect(find.text('or'), findsOneWidget);
    expect(find.text('Daftar with Email'), findsOneWidget);
    expect(find.text('Sudah punya account? '), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Register uses CustomScrollView (advanced layout)', (
    WidgetTester tester,
  ) async {
    await pumpWithAuth(tester, const RegisterScreen());
    expect(find.byType(CustomScrollView), findsOneWidget);
  });

  testWidgets('Register Login navigates to LoginScreen', (
    WidgetTester tester,
  ) async {
    await pumpWithAuth(tester, const RegisterScreen());
    final loginLink = find.text('Login');
    await tester.scrollUntilVisible(loginLink, 200);
    await tester.pumpAndSettle();
    await tester.tap(loginLink);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Login renders topbar, inputs, and bottom buttons', (
    WidgetTester tester,
  ) async {
    await pumpWithAuth(tester, const LoginScreen());

    expect(find.text('Selamat datang'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Lupa password?'), findsOneWidget);
    expect(find.text('Ganti sekarang'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Password visibility toggles via local setState', (
    WidgetTester tester,
  ) async {
    await pumpWithAuth(tester, const LoginScreen());

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('Email login reflects instantly on Register', (
    WidgetTester tester,
  ) async {
    await pumpWithAuth(tester, const RegisterScreen());

    // @dev Go to Login, type valid credentials, submit, pop back.
    await tester.scrollUntilVisible(find.text('Login'), 200);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'mhs@kampus.ac.id');
    await tester.enterText(find.byType(TextField).at(1), '1234');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    // @dev Back on Register: global state reflected instantly.
    expect(find.byType(RegisterScreen), findsOneWidget);
    expect(find.textContaining('Signed in as'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });
}
