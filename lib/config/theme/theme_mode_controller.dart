import 'package:flutter/material.dart';
import 'theme_storage.dart';

class ThemeModeController extends ChangeNotifier {
  final ThemeStorage _storage;

  ThemeMode _themeMode = ThemeMode.light;

  ThemeModeController(this._storage);

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> init() async {
    _themeMode = await _storage.loadThemeMode();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    await _storage.saveThemeMode(_themeMode);
    notifyListeners();
  }
}
