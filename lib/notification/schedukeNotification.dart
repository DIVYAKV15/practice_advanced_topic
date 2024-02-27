import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:practice_advanced_topic/notification/notificationPermission.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;


void main()
{
  runApp(MaterialApp(home: Notification(),));
}

Future scheduleNotification(String? title,DateTime? time)
async{
  // Print the provided time for debugging
  print('Provided time: $time');

  await Request().requestNotificationPermission();
  // Parse the time string into a DateTime object
 // DateTime parsedTime = DateFormat.jm().parse(time!);

  // Initialize the timezone database
  tzdata.initializeTimeZones();

  // Schedule notification based on the provided time
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // Initialize the Android-specific settings for the notification
  var androidSettings = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.high,
    priority: Priority.high,
    icon:
    '@mipmap/ic_launcher', // Replace with your small icon name without the extension
  );

  // Initialize the notification details
  var notificationDetails =
  NotificationDetails(android: androidSettings, iOS: null);

  // Get the device's timezone
  var deviceTimeZone = tz.local;

  // Convert the provided time to the device's timezone
  var scheduledTime = tz.TZDateTime.from(time!, tz.local);


  // Schedule the notification

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    title!,
    title!,
    scheduledTime,
    notificationDetails,
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
    payload: 'Custom_Sound',
  );
}
class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  final textController = TextEditingController();
  DateTime? selectedDateTime;
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(title: const Text("Reminder app")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextField(
                controller: textController,
                decoration:
                const InputDecoration(hintText: "Enter reminder text"),
              ),
            ),
            ElevatedButton(
              onPressed: () => selectDateTime(context),
              child: Text(selectedDateTime == null
                  ? "Select date and time"
                  : "Change date and time"),
            ),
            if (selectedDateTime != null) ...[
              Text('selected date and time :${selectedDateTime!.toLocal()}'),
              ElevatedButton(
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    scheduleNotification(
                        textController.text, selectedDateTime);
                    textController.clear();
                    setState(() {
                      selectedDateTime = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Reminder Set Successfully"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter reminder text'),
                      ),
                    );
                  }
                },
                child: const Text('set Reminder'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    // Specifies the latest selectable date in the date picker as 365 days (1 year) from the current date.
    if (picked != null) {
      final TimeOfDay? time =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        setState(() {
          selectedDateTime = DateTime(
              picked.year, picked.month, picked.day, time.hour, time.minute);
        });
      }
    }
  }
}
