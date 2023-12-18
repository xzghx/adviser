import 'package:flutter/cupertino.dart';

class ThemeService extends ChangeNotifier {
  bool isDarkMode = true;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
