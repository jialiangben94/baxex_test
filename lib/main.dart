import 'package:baseX/Core/base_config.dart';
import 'package:baseX/const/base_constant.dart';
import 'package:baxex_test/app/config/app_constant.dart';
import 'package:baxex_test/app/config/base_x_config.dart';
import 'package:baxex_test/app/config/language_controller.dart';
import 'package:baxex_test/app/routes/app_routes.dart';
import 'package:baxex_test/app/ui/auth/main/main_binding.dart';
import 'package:baxex_test/app/ui/auth/main/main_page.dart';
import 'package:baxex_test/app/util/app_theme.dart';
import 'package:flutter/services.dart';

void main() {
  runEtcApp(
    currentEnv: Environment.Staging,
    staginBaseUrl: "",
    liveBaseUrl: "",
    requireSharePref: true,
    isLightMode: false,
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
