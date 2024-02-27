import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future sendLocalNotification(String? title, String? content) async {
  // Send Local Notification only Android
  // Initialize the FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // Configure the Android initialization settings
  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  // Configure the initialization settings for the FlutterLocalNotificationsPlugin
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: null, macOS: null);
  // Initialize the FlutterLocalNotificationsPlugin with the initialization settings
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // Configure the notification details
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', "channel_name",
      importance: Importance.max, priority: Priority.high, ticker: 'ticker');
  // Configure the notification
  var notificationDetails =
      NotificationDetails(android: androidPlatformChannelSpecifics, iOS: null);
  //  Show the notification
    await flutterLocalNotificationsPlugin.show(
      0,
      title ?? '', // Use title parameter here
      content ?? '', // Use content parameter here
      notificationDetails,
      payload: 'item x',
    );
}
