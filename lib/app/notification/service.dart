import 'package:flutter/material.dart';
import 'package:flutter_app/app/notification/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  BuildContext? _context;
  NotificationService(BuildContext? context) {
    _context = context;
  }

  Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    var fln = await LocalNoti().fln;
    AndroidNotificationDetails androidNotificationDetails =
        new AndroidNotificationDetails(
      "cid",
      "cn",
      playSound: true,
      // sound: RawResourceAndroidNotificationSound(),
      importance: Importance.max,
      priority: Priority.high,
    );

    var noti = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );
    await fln.show(0, title, body, noti);
  }

  Future addScheduleNoti({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    var fln = await LocalNoti().fln;
    AndroidNotificationDetails androidNotificationDetails =
        new AndroidNotificationDetails(
      "cid",
      "cn",
      playSound: true,
      // sound: RawResourceAndroidNotificationSound(),
      importance: Importance.max,
      priority: Priority.high,
    );

    var noti = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );
    await fln.zonedSchedule(0, title, body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), noti,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
