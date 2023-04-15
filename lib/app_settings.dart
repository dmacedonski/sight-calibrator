import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier
    implements ValueListenable<AppSettings> {
  static AppSettings? _instance;

  static AppSettings getInstance() {
    _instance ??= AppSettings();
    return _instance as AppSettings;
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    switch (prefs.getInt("theme_mode")) {
      case 1:
        _themeMode = ThemeMode.light;
        break;
      case 2:
        _themeMode = ThemeMode.dark;
        break;
      default:
        _themeMode = ThemeMode.system;
        break;
    }
    notifyListeners();
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    switch (themeMode) {
      case ThemeMode.light:
        prefs.setInt("theme_mode", 1);
        break;
      case ThemeMode.dark:
        prefs.setInt("theme_mode", 2);
        break;
      default:
        prefs.setInt("theme_mode", 0);
        break;
    }
  }

  @override
  AppSettings get value => this;
}
