import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  bool _isDarkMode = false;

  //getters
  bool get isDarkMode => _isDarkMode;

  //Methods
  void toggle() {
    _isDarkMode = !_isDarkMode;
    print("current theme ${_isDarkMode}");
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isDarkMode ? ThemeData.dark() : ThemeData.light();
  }
}
