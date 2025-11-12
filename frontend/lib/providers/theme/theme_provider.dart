import 'package:flutter/material.dart';
import 'package:blindds_app/ui/style/theme/app_themes.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get currentTheme =>
      _themeMode == ThemeMode.dark ? AppThemes.darkTheme : AppThemes.lightTheme;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
