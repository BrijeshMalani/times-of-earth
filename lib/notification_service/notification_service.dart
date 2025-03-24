import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../common/image_path.dart';

class NotificationServices {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings(ImagePath.logo);

  Future<void> initialiseNotifications() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: onSelectNotification
    );
  }
  // ... other code ...

  void sendNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      // 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    // const IOSNotificationDetails iOSPlatformChannelSpecifics =
    // IOSNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
      // androidAllowWhileIdle: true,
    );
  }

  void sendNotificationPeriodically(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      // 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    // const IOSNotificationDetails iOSPlatformChannelSpecifics =
    // IOSNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0, // Notification ID
      title,
      body,
      RepeatInterval.everyMinute, // Set the interval here
      platformChannelSpecifics,
      // androidAllowWhileIdle: true,
    );
  }

  void stopNotification() {
    flutterLocalNotificationsPlugin.cancel(0);
  }

  void stopAllNotification() {
    flutterLocalNotificationsPlugin.cancelAll();
  }
}
