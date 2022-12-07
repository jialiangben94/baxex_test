import 'package:baseX/baseX.dart';
import 'package:baxex_test/app/config/app_constant.dart';
import 'package:baxex_test/app/config/base_x_config.dart';
import 'package:baxex_test/app/config/language_controller.dart';
import 'package:baxex_test/app/routes/app_routes.dart';
import 'package:baxex_test/app/ui/auth/main/main_binding.dart';
import 'package:baxex_test/app/ui/auth/main/main_page.dart';
import 'package:baxex_test/app/util/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runEtcApp(
    currentEnv: Environment.Staging,
    staginBaseUrl: "test",
    liveBaseUrl: "test",
    requireSharePref: true,
    themeMode: ThemeMode.system,
    onFailed: (context, code, msg, {tryAgain}) {
      return false;
    },
    allowOrientationList: [DeviceOrientation.portraitUp],
    title: "BaseX Test",
    theme: appThemeData,
    getPages: AppPages.routes,
    initialPage: MainPage(),
    initialBinding: MainBindings(),
    appLanguage: LanguageController(),
    constantFile: AppConstant(),
    baseXConfig: BaseXConfig(),
    // firebaseNotificationController: PushNotitificationController(),
    // additionalFunction: () {},
    // additionalWidget: (materialApp) => materialApp,
  );
}
