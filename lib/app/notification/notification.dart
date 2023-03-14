import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNoti {
  static FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  Future<FlutterLocalNotificationsPlugin> _initNotification() async {
    final AndroidInitializationSettings androidSettings =
        new AndroidInitializationSettings("mipmap/ic_launcher");
    final DarwinInitializationSettings iosSettings =
        new DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    var plugin = FlutterLocalNotificationsPlugin();
    await plugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onReceiveLocalNotification,
    );
    return plugin;
  }

  Future<FlutterLocalNotificationsPlugin> get fln async {
    if (_flutterLocalNotificationsPlugin != null)
      return _flutterLocalNotificationsPlugin!;

    return await _initNotification();
  }

  onReceiveLocalNotification(NotificationResponse response) async {}
}
