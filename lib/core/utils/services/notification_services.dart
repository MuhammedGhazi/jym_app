import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifyHelper {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitalize =
        const AndroidInitializationSettings("mipmap/ic_launcher");
    var initializationSettings =
        InitializationSettings(android: androidInitalize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showBigTextNotification(
      {int id = 0,
      required String title,
      required String body,
      var payLoad,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("channelId", "channelName",
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await fln.show(id, title, body, notificationDetails);
  }
}
