import 'package:flutter/foundation.dart';
import 'package:shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _isCelsius = true;
  bool _enableNotifications = true;

  bool get isDarkMode => _isDarkMode;
  bool get isCelsius => _isCelsius;
  bool get enableNotifications => _enableNotifications;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isCelsius = prefs.getBool('isCelsius') ?? true;
    _enableNotifications = prefs.getBool('enableNotifications') ?? true;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> toggleTemperatureUnit() async {
    _isCelsius = !_isCelsius;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCelsius', _isCelsius);
    notifyListeners();
  }

  Future<void> toggleNotifications() async {
    _enableNotifications = !_enableNotifications;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enableNotifications', _enableNotifications);
    notifyListeners();
  }
}