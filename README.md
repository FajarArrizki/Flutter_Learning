# Flutter Catalog App — Navigation & State (Assignment #5)

A Flutter application that demonstrates **routing/navigation** between screens using `Navigator.push` (Stack Navigation), along with the **Event & State** concept implemented in a `StatefulWidget`.

## Features

- **Screen 1 — Home (`HomeScreen`)**: a `StatelessWidget` that renders 3 catalog cards inside a `ListView`. Every item uses a `Card` + `ListTile` that can be tapped.
- **Screen 2 — Detail (`DetailScreen`)**: a `StatefulWidget` with a vertical layout (`Column`) showing the catalog name, price, and a pastel-colored description container.
- **Navigation**: moving from Home ➜ Detail uses `Navigator.push` with `MaterialPageRoute`, while the `AppBar` provides an automatic back button (Stack Navigation / `Navigator.pop`).
- **Event & State**:
  - *User event*: the "Tandai Favorit" button toggles `isFavorite` through `setState()`, so the button color, icon, and label update reactively.
  - *System event*: a `Timer.periodic` started in `initState()` increments `secondsViewed` every second and is cancelled in `dispose()` to prevent a memory leak.

## Project Structure

```
lib/
├── main.dart                     # Entry point + MaterialApp (home: HomeScreen)
├── models/
│   └── katalog_item.dart         # Catalog data model (name, price, description, pastel color)
├── screens/
│   ├── home_screen.dart          # Screen 1 (Home) — StatelessWidget
│   └── detail_screen.dart        # Screen 2 (Detail) — StatefulWidget
└── user_model.dart               # Previous session material (JSON serialization)
test/
├── widget_test.dart              # Navigation & state interaction tests
└── user_model_test.dart          # Model tests from the previous session
```

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) version **3.13** or newer (developed with Flutter 3.47 / Dart 3.13).
- Android Studio or VS Code with the Flutter extension.
- An Android emulator, iOS simulator, or Chrome browser to run the app.

Verify your installation with:

```bash
flutter doctor
```

## Project Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/FajarArrizki/Flutter_Learning.git
   cd Flutter_Learning
   ```

2. Download all dependencies:

   ```bash
   flutter pub get
   ```

## Running the App (Local Debug Server)

```bash
# List available devices
flutter devices

# Run on an Android device/emulator
flutter run

# Run in the Chrome browser
flutter run -d chrome

# If Chrome is not detected, point Flutter to your Chromium binary
CHROME_EXECUTABLE=/usr/bin/chromium flutter run -d chrome
```

The app can also be launched straight from VS Code or Android Studio by pressing the **Run ▶** button. While running, press `r` for hot reload and `q` to quit.

## Testing & Static Analysis

```bash
# Run all unit & widget tests
flutter test

# Run the static analyzer (lint)
flutter analyze
```

## Database

This project **does not require a MySQL database**. All catalog data is static and defined inside the app (`HomeScreen.katalog`), so there is no database import or migration step to perform. Simply run `flutter pub get` followed by `flutter run`.

## References

- [Project Sample — kurikulum-test-case-UB](https://github.com/rafli21xrplc/kurikulum-test-case-UB)
- [Event & State example — detail_screen.dart](https://github.com/rafli21xrplc/kurikulum-test-case-UB/blob/event-state/lib/screens/detail_screen.dart)
