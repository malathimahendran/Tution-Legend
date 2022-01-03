import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class MessageNotification {
  static final l = Logger();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static initialize() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('ic_launcher'));

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static messageDisplay(RemoteMessage message) async {
    try {
      l.d(message.data);
      l.d(message.notification!.title);
      l.d(message);
      final id = (DateTime.now().millisecondsSinceEpoch) ~/ 100000000;
      // int id = 1;
      l.d(id.runtimeType);

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("hello", "my name is pravin",
              importance: Importance.max, priority: Priority.high));

      l.wtf(id);
      l.wtf(message.notification!.title);
      l.wtf(notificationDetails.android);

      await flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title ?? "",
          "how are you in body",
          notificationDetails);
      l.wtf(message.notification!.title);
      l.wtf(message.data['message']);
      // var androidDetails = new AndroidNotificationDetails(
      //     "Channel ID", "Desi programmer", "This is my channel",
      //     importance: Importance.max);
      // // var iSODetails = new IOSNotificationDetails();
      // var generalNotificationDetails = new NotificationDetails(
      //   android: androidDetails,
      // );

      // flutterLocalNotificationsPlugin.show(1, message.data['title'] ?? "",
      //     message.data['message'] ?? "", generalNotificationDetails);
    } on Exception catch (e) {
      l.e(e);
    }
  }
}
