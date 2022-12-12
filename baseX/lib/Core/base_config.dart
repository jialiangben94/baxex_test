import 'package:baseX/baseX.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';

late BaseConstant baseConstant;
late BaseX baseXWidgetConfig;

typedef AddtionalWidget = Widget Function(Widget child);

/// title => Set Project title
///
/// theme => Set Project app theme
///
/// themeMode => Enable dark mode, if null being pass, will disable dark mode. Default value is null
///
/// currentEnv => Set current environment. Staging or Live
///
/// liveBaseUrl => Set live base url. Required if currentEnv is live
///
/// staginBaseUrl => Set staging base url. Required if currentEnv is staging
///
/// requireSharePref => Enable Share Pref, by default is disabled
///
/// allowOrientationList => Set allowed Orientation List
///
/// onFailed => Set Global onFailed
///
/// firebaseNotificationController => Enable FCM, will disable function if no object being pass
///
/// constantFile => Custom Base Constant, will have a default constant file if no object being pass
///
/// appLanguage => Enable App Langauge, will disable function if no object being pass
///
/// baseXConfig => Custom Base Config, will have a default config file if no object being pass
///
/// getPages => Register all page route with binding (if any)
///
/// initialBinding => Set Global Binding
///
/// additionalFunction => Add additional function before runEtcApp
///
/// additionalWidget => Add additional widget before material app

void runEtcApp({
  required String title,
  required ThemeData theme,
  ThemeMode? themeMode,
  Environment currentEnv = Environment.Staging,
  required String liveBaseUrl,
  required String staginBaseUrl,
  required bool requireSharePref,
  required List<DeviceOrientation> allowOrientationList,
  required GeneralErrorHandle onFailed,
  FirebaseNotificationController? firebaseNotificationController,
  BaseConstant? constantFile,
  AppTranslationX? appLanguage,
  BaseX? baseXConfig,
  required List<GetPage<dynamic>> getPages,
  required BaseXWidget initialPage,
  required Bindings initialBinding,
  Function? additionalFunction,
  AddtionalWidget? additionalWidget,
}) {
  //Check required field
  assert(!(appLanguage != null && !requireSharePref),
      'Required Share Preference to enable App Language');
  assert(!(firebaseNotificationController != null && !requireSharePref),
      'Required Share Preference to enable Firebase Notification');

  //Set Constant File
  baseConstant = constantFile ?? DefaultBaseContant();

  //Set BaseX File
  baseXWidgetConfig = baseXConfig ?? DefaulBaseX();
  FlutterStatusbarcolor.setStatusBarWhiteForeground(
      baseXWidgetConfig.statusBarTextWhiteColor);

  //Set Base Url
  baseConstant.staginBaseUrl = staginBaseUrl;
  baseConstant.baseUrl = liveBaseUrl;

  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Share Preference
  if (requireSharePref) {
    SharePref.sharePref.initialize();
  }

  //Set Gloabal onFailed
  baseConstant.onFailed = onFailed;

  //Set available orientation
  if (allowOrientationList != null) {
    SystemChrome.setPreferredOrientations(allowOrientationList);
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
    themeMode: themeMode,
    additionalWidget: additionalWidget,
  ));
}

class MyApp extends StatelessWidget {
  final String title;
  final ThemeData theme;
  final ThemeMode? themeMode;
  final List<GetPage<dynamic>> getPages;
  final BaseXWidget initialPage;
  final Bindings initialBinding;
  final AppTranslationX? appLanguage;
  final AddtionalWidget? additionalWidget;
  const MyApp({
    required this.title,
    required this.theme,
    required this.getPages,
    required this.initialPage,
    required this.initialBinding,
    this.appLanguage,
    this.themeMode,
    this.additionalWidget,
  });

  Widget materialApp() {
    return GetMaterialApp(
      title: title,
      theme: themeMode == null
          ? theme
          : theme.copyWith(brightness: Brightness.light),
      darkTheme: themeMode == null
          ? null
          : theme.copyWith(brightness: Brightness.dark),
      themeMode: (themeMode == null) ? ThemeMode.light : themeMode!,
      getPages: getPages,
      initialRoute: initialPage.routeName,
      initialBinding: initialBinding,
      locale: appLanguage?.appLocale,
      localizationsDelegates: appLanguage == null
          ? []
          : [
              appLanguage!.appLocalizationsX.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return additionalWidget == null
        ? materialApp()
        : additionalWidget!(materialApp());
  }
}
