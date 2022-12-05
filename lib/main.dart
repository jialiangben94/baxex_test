import 'package:baseX/Core/base_config.dart';
import 'package:baseX/const/base_constant.dart';
import 'package:baxex_test/app/config/app_constant.dart';
import 'package:baxex_test/app/config/base_x_config.dart';
import 'package:baxex_test/app/config/language_controller.dart';
import 'package:baxex_test/app/config/push_notification_controller.dart';
import 'package:baxex_test/app/routes/app_routes.dart';
import 'package:baxex_test/app/ui/auth/main/main_binding.dart';
import 'package:baxex_test/app/ui/auth/main/main_page.dart';
import 'package:baxex_test/app/util/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runEtcApp(
    currentEnv: Environment.Live,
    staginBaseUrl: "",
    liveBaseUrl: "",
    requireSharePref: true,
    onFailed: (context, code, msg, {tryAgain}) {
      return false;
    },
    title: "Flutter Demo",
    theme: appThemeData,
    getPages: AppPages.routes,
    initialPage: MainPage(),
    initialBinding: MainBindings(),
    // appLanguage: LanguageController(),
    constantFile: AppConstant(),
    baseXConfig: BaseXConfig(),
    // firebaseNotificationController: PushNotitificationController(),
  );
}
