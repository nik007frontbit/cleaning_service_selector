// import 'dart:async';
// import 'dart:developer';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../config/local_storage.dart';
// import '../utils/local_storage/shared_preferences.dart';
//
// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });
//
//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }
//
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   debugPrint("Handling a background message: ${message.messageId}");
//   NotificationService().showFlutterNotification(message);
// }
// class NotificationService {
//   final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
//       StreamController<ReceivedNotification>.broadcast();
//
//
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   AndroidNotificationChannel? channel;
//
//   void showFlutterNotification(RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     if (notification != null && android != null && channel != null) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel!.id,
//             channel!.name,
//             channelDescription: channel!.description,
//             importance: Importance.max,
//             icon: '@mipmap/ic_launcher',
//           ),
//         ),
//       );
//     }
//   }
//
//   Future<void> init() async {
//     @pragma('vm:entry-point')
//     void notificationTapBackground(NotificationResponse notificationResponse) {
//       if (notificationResponse.input?.isNotEmpty ?? false) {}
//     }
//
//     await registerNotification();
//     print("Here Fb Token");
//
//     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: false,
//       requestAlertPermission: true,
//     );
//
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//     );
//
//     channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       description: 'This channel is used for important notifications.',
//       // description
//       importance: Importance.max,
//     );
//
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel!);
//   }
//
//   String? token;
//
//   Future<void> registerNotification() async {
//     print("Here .. Hello ");
//     // if (Platform.isAndroid) {
//     //   token = await FirebaseMessaging.instance.getToken();
//     // } else {
//     //   token = await FirebaseMessaging.instance.getAPNSToken();
//     // }
//     token = await FirebaseMessaging.instance.getToken();
//     print("Token: $token");
//     await setDataToLocalStorage(
//         dataType: LocalStorageData.stringType, prefKey: LocalStorageData.fcmToken, stringData: token);
//
//     NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         print("Foreground message received: ${message.notification?.title}");
//         showFlutterNotification(message);
//       });
//
//       FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//         print("Notification opened: ${message.notification?.title}");
//       });
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
// }
