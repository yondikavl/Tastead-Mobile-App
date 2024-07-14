import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tastead/helpers/notification_helper.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class SettingsProvider with ChangeNotifier {
  bool _isReminderEnabled = false;

  bool get isReminderEnabled => _isReminderEnabled;

  SettingsProvider() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderEnabled = prefs.getBool('isReminderEnabled') ?? false;
    notifyListeners();

    if (_isReminderEnabled) {
      await _scheduleDailyReminder();
    }
  }

  Future<void> setReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderEnabled = value;
    await prefs.setBool('isReminderEnabled', value);

    if (value) {
      await _scheduleDailyReminder();
    } else {
      await AndroidAlarmManager.cancel(0); // Membatalkan alarm jika dimatikan
    }
    notifyListeners();
  }

  Future<void> _scheduleDailyReminder() async {
    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      0,
      NotificationHelper.showDailyReminder,
      startAt: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 11),
      exact: true,
      wakeup: true,
    );
  }
}
