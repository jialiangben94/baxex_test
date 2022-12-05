import 'package:baseX/baseX.dart';
import 'package:baseX/const/firebase_notification_controller.dart';
import 'package:baseX/const/share_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

BaseConstant baseConstant;
BaseX baseXWidgetConfig;

void runEtcApp({
  Environment currentEnv = Environment.Staging,
  String liveBaseUrl,
  String staginBaseUrl,
  bool requireSharePref,
  List<DeviceOrientation> allowOrientationList,
  GeneralErrorHandle onFailed,
  FirebaseNotificationController firebaseNotificationController,
  BaseConstant constantFile,
  AppTranslationX appLanguage,
  BaseX baseXConfig,
  String title,
  ThemeData theme,
  bool isLightMode = true,
  List<GetPage<dynamic>> getPages,
  @required BaseXWidget initialPage,
  Bindings initialBinding,
  Function additionalFunction,
}) {
  //Check required field
  assert(initialPage != null, 'Initial Page is required');
  assert(title != null, 'Title is required');
  assert(!(appLanguage != null && !requireSharePref),
      'Required Share Preference to enable App Language');
  assert(!(firebaseNotificationController != null && !requireSharePref),
      'Required Share Preference to enable Firebase Notification');

  //Set Constant File
  baseConstant = constantFile ?? DefaultBaseContant();

  //Set BaseX File
  baseXWidgetConfig = baseXConfig ?? DefaulBaseX();

  //Check for evironment and required base ur
  if (currentEnv == Environment.Staging) {
    assert(staginBaseUrl != null, "Staging Base Url is required");
    baseConstant.staginBaseUrl = staginBaseUrl;
  } else {
    assert(liveBaseUrl != null, "Live Base Url is required");
    baseConstant.baseUrl = liveBaseUrl;
  }

  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Share Preference
  if (requireSharePref) {
    SharePref.sharePref.initialize();
  }

  //Set Gloabal onFailed
  baseConstant.onFailed = onFailed;

  //Set available orientation
  if (allowOrientationList != null) {
    baseXWidgetConfig.setAllowedOrientation(allowOrientationList);
  }

  //Initialize Firebase Notification Controller if Exists
  firebaseNotificationController?.initialize();

  //Set App Language
  if (appLanguage != null) {
    appTranslationX = appLanguage;
  }

  //Additional Function required before run app
  if (additionalFunction != null) {
    additionalFunction();
  }

  runApp(MyApp(
    title: title,
    theme: theme,
    getPages: getPages,
    initialPage: initialPage,
    initialBinding: initialBinding,
    appLanguage: appLanguage,
    isLightMode: isLightMode,
  ));
}

class MyApp extends StatelessWidget {
  final String title;
  final ThemeData theme;
  final List<GetPage<dynamic>> getPages;
  final BaseXWidget initialPage;
  final Bindings initialBinding;
  final AppTranslationX appLanguage;
  final bool isLightMode;
  const MyApp({
    this.title,
    this.theme,
    this.getPages,
    this.initialPage,
    this.initialBinding,
    this.appLanguage,
    this.isLightMode,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: title,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isLightMode ? ThemeMode.light : ThemeMode.dark,
      getPages: getPages,
      initialRoute: initialPage.routeName,
      initialBinding: initialBinding,
      locale: appLanguage?.appLocale,
      localizationsDelegates: appLanguage == null
          ? []
          : [
              appLanguage.appLocalizationsX.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
    );
  }
}
