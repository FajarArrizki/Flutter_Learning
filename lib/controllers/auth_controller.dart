import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

/// @title AuthController
/// @notice Global authentication state (login status) shared across screens.
/// @dev Used via Provider ({ChangeNotifier}). This file is SEPARATED from the
/// UI to meet the logic-view separation requirement.
/// @author Kosply slicing-ui
class AuthController extends ChangeNotifier {
  /// @dev Email typed in the LoginScreen.
  String _email = '';

  /// @dev Password typed in the LoginScreen.
  String _password = '';

  /// @dev The signed-in user, null when nobody is signed in.
  UserModel? _user;

  /// @dev The latest validation error, null when there is no error.
  String? _error;

  /// @notice The current email input.
  /// @return The email string.
  String get email => _email;

  /// @notice Whether a user is currently signed in.
  /// @return True when {_user} is not null.
  bool get isLoggedIn => _user != null;

  /// @notice The signed-in user.
  /// @return The {UserModel}, or null.
  UserModel? get user => _user;

  /// @notice The latest error message.
  /// @return The error string, or null.
  String? get error => _error;

  /// @notice Stores the email from the login TextField.
  /// @dev Calls {notifyListeners} so Register reflects it instantly.
  /// @param value The new email value.
  void setEmail(String value) {
    _email = value.trim();
    _error = null;
    notifyListeners();
  }

  /// @notice Stores the password from the login TextField.
  /// @param value The new password value.
  void setPassword(String value) {
    _password = value;
    _error = null;
    notifyListeners();
  }

  /// @notice Simple email & password validation.
  /// @return True when both inputs are valid.
  bool get canLogin => _email.contains('@') && _password.length >= 4;

  /// @notice Signs in with the typed email & password.
  /// @dev Fills {_user} on success, fills {_error} on failure.
  /// Called from the Login button (LoginScreen).
  /// @param email Optional override, used to sign in without typing first.
  /// @return True when sign-in succeeds.
  bool login({String? email}) {
    final target = (email ?? _email).trim();
    final pass = email != null ? 'social' : _password;
    if (!target.contains('@') || pass.length < 4) {
      _error = 'Invalid email / password';
      notifyListeners();
      return false;
    }
    _user = UserModel(email: target);
    _error = null;
    notifyListeners();
    return true;
  }

  /// @notice Social sign-in (Google / Apple) without typing.
  /// @dev Uses a placeholder email so the login status is broadcast.
  /// @param provider Provider name, e.g. 'google' or 'apple'.
  /// @return Always true for this slicing stage.
  bool socialLogin(String provider) {
    _user = UserModel(email: 'user@$provider.kosply');
    _error = null;
    notifyListeners();
    return true;
  }

  /// @notice Signs out the current user.
  /// @dev Clears {_user} and broadcasts to every screen.
  void logout() {
    _user = null;
    _error = null;
    notifyListeners();
  }
}
