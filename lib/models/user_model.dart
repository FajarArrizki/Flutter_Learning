/// @title UserModel
/// @notice Plain user data for the login feature.
/// @dev Pure data class, must not import Flutter.
/// @author Kosply slicing-ui
class UserModel {
  /// @notice Creates user data.
  /// @param email The email of the signed-in user.
  /// @param displayName Optional display name.
  /// @return A new {UserModel} instance.
  const UserModel({required this.email, this.displayName});

  /// @dev The user email.
  final String email;

  /// @dev The user display name, may be empty.
  final String? displayName;

  /// @notice The name shown in the UI.
  /// @dev Returns {displayName} when set, otherwise falls back to {email}.
  /// @return The display name string.
  String get shownName => displayName ?? email;
}
