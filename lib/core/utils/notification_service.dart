import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationService() {
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
  }
  AndroidNotificationChannel channel =  const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);

  void showNotification(RemoteMessage message) {
    final notification = message.notification;
    flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification!.title ?? "No title",
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              importance: Importance.max,
              priority: Priority.high
            ),
          ),
        );
  }
}
