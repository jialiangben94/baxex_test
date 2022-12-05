import 'dart:developer';

import 'package:baseX/const/share_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

abstract class FirebaseNotificationController<T> {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //Local Channel
  AndroidNotificationChannel get channel => AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound("default"),
      );

  //Enable Sound Setting
  bool get soundEnable => true;

  //Enable Badge Setting
  bool get badgeEnable => true;

  //Enable Alert Setting
  bool get alertEnable => true;

  //Receive FCM Token Function
  void receiveToken(String token);

  //On Error Receive FCM Token Funtion;
  void onErrorToken(dynamic error);

  //On Launch Message Function
  void onLaunchMessage(RemoteMessage message);

  //On Foreground Message Function
  void onMessage(RemoteMessage message);

  //On Background Message Function
  void onMessageOpenedApp(RemoteMessage message);

  //Dynamic Reactive Type
  Rx<T> notificationData = Rx(null);

  //Initialize Function
  void initialize() async {
    _createChannel();
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
        sound: soundEnable, badge: badgeEnable, alert: alertEnable);
    log('User granted permissions: ${settings.authorizationStatus}');

    _firebaseMessaging.getToken().then((token) async {
      if (receiveToken != null) {
        receiveToken(token);
      }
      SharePref.sharePref?.saveFcmToken(token);
      log('fcmToken: $token');
    }).catchError((error) {
      if (onErrorToken != null) {
        onErrorToken(error);
      }
      log('fcmError $error');
    });

    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null && onLaunchMessage != null) {
      log('onLaunch: $initialMessage');
      onLaunchMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      log('onMessage: {notification: ${event?.notification?.body}, data: ${event?.data}}');
      if (onMessage != null) {
        onMessage(event);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      log('onResume: {notification: ${event.notification}, data: ${event.data}}');
      if (onMessageOpenedApp != null) {
        onMessageOpenedApp(event);
      }
    });
  }

  //Channel Creation
  void _createChannel() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
