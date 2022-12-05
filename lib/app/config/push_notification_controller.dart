import 'dart:developer';

import 'package:baseX/baseX.dart';
import 'package:baseX/const/firebase_notification_controller.dart';

class PushNotitificationController extends FirebaseNotificationController {
  @override
  void onErrorToken(error) {
    // TODO: implement onErrorToken
    log(error.toString());
  }

  @override
  void onLaunchMessage(RemoteMessage message) {
    // TODO: implement onLaunchMessage
  }

  @override
  void onMessage(RemoteMessage message) {
    // TODO: implement onMessage
  }

  @override
  void onMessageOpenedApp(RemoteMessage message) {
    // TODO: implement onMessageOpenedApp
  }

  @override
  void receiveToken(String token) {
    // TODO: implement receiveToken
    log(token);
  }
}
