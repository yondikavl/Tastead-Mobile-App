import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tastead/services/api_services.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    final String timeZoneName =
        (await tz.getLocation('Asia/Jakarta')) as String;
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showDailyReminder() async {
    final restaurants = await ApiService().listRestaurant();
    var randomIndex = Random().nextInt(restaurants.length);
    var randomRestaurant = restaurants[randomIndex];

    const androidDetails = AndroidNotificationDetails(
      'daily_reminder_channel',
      'Daily Reminder',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.zonedSchedule(
      0,
      'Daily Reminder',
      'Cek restoran ini: ${randomRestaurant['name']} di ${randomRestaurant['city']}',
      _nextInstanceOf11AM(),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _nextInstanceOf11AM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
