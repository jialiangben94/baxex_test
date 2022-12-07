import 'package:baseX/baseX.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

BaseConstant baseConstant;
BaseX baseXWidgetConfig;

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
  String title,
  ThemeData theme,
  ThemeMode themeMode,
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
  List<GetPage<dynamic>> getPages,
  @required BaseXWidget initialPage,
  Bindings initialBinding,
  Function additionalFunction,
  AddtionalWidget additionalWidget,
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
    assert(staginBaseUrl.isNotEmpty, "Staging Base Url is required");
    baseConstant.staginBaseUrl = staginBaseUrl;
  } else {
    assert(liveBaseUrl.isNotEmpty, "Live Base Url is required");
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
    themeMode: themeMode,
    additionalWidget: additionalWidget,
  ));
}

class MyApp extends StatelessWidget {
  final String title;
  final ThemeData theme;
  final ThemeMode themeMode;
  final List<GetPage<dynamic>> getPages;
  final BaseXWidget initialPage;
  final Bindings initialBinding;
  final AppTranslationX appLanguage;
  final AddtionalWidget additionalWidget;
  const MyApp({
    this.title,
    this.theme,
    this.getPages,
    this.initialPage,
    this.initialBinding,
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
      themeMode: (themeMode == null) ? ThemeMode.light : themeMode,
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

  @override
  Widget build(BuildContext context) {
    return additionalWidget == null
        ? materialApp()
        : additionalWidget(materialApp());
  }
}
