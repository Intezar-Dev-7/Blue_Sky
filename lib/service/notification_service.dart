import 'dart:ffi';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings andriodInit =
        AndroidInitializationSettings('@drawable/ic_launcher_foreground.png');
    const InitializationSettings initSettings =
        InitializationSettings(android: andriodInit);

    await _notificationsPlugin.initialize(initSettings);
  }

  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails andriodDetails =
        AndroidNotificationDetails(
      'weather_channel',
      'Weather Updates',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: andriodDetails);
    await _notificationsPlugin.show(0, title, body, details);
  }
}
