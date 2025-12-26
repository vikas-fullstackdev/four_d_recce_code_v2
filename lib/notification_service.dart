// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notifications =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     tz.initializeTimeZones();

//     const AndroidInitializationSettings androidSettings =
//         AndroidInitializationSettings('@drawable/ic_notification');

//     const DarwinInitializationSettings iosSettings =
//         DarwinInitializationSettings();

//     const InitializationSettings settings =
//         InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );

//     await _notifications.initialize(settings);
//   }

//   static Future<void> showNotification({
//     required String title,
//     required String body,
//   }) async {
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'local_channel',
//       'Local Notifications',
//       channelDescription: 'Local notification channel',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const NotificationDetails details =
//         NotificationDetails(android: androidDetails);

//     await _notifications.show(
//       0,
//       title,
//       body,
//       details,
//     );
//   }
// }
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// CALL THIS IN main() BEFORE runApp()
  static Future<void> init() async {
    // Initialize timezone
    tz.initializeTimeZones();

    // ANDROID SETTINGS
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // IOS SETTINGS
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize plugin
    await _notifications.initialize(settings);

    // ANDROID 13+ NOTIFICATION PERMISSION
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      await androidPlugin.requestNotificationsPermission();
    }
  }

  /// SIMPLE INSTANT NOTIFICATION
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'local_channel_id',
      'Local Notifications',
      channelDescription: 'Local notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notifications.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }
}
