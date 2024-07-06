import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool _isReminderEnabled = false;

  bool get isReminderEnabled => _isReminderEnabled;

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderEnabled = prefs.getBool('isReminderEnabled') ?? false;
    notifyListeners();
  }

  Future<void> setReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderEnabled = value;
    await prefs.setBool('isReminderEnabled', value);
    notifyListeners();
  }
}
