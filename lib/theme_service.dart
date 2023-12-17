import 'package:flutter/material.dart';

class ThemeService extends ChangeNotifier {
  ThemeService({this.darkMode = true});

  final bool darkMode;

  bool get isDarkMode {
    return darkMode;
  }

  void toggleTheme() {
    darkMode != darkMode;
    notifyListeners();
  }

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor:
        ColorScheme.fromSeed(seedColor: Colors.purpleAccent.shade100).primary,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor:
        ColorScheme.fromSeed(seedColor: Colors.purpleAccent.shade200).primary,
  );
}
