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

typedef AddtionalWidget = Widget Function(Widget child);

void runEtcApp({
  Environment currentEnv = Environment.Staging, //Set current environment
  String liveBaseUrl, //Set live base url
  String staginBaseUrl, //Set staging base url
  bool requireSharePref, //Enable Share Pref, by default is disabled
  List<DeviceOrientation> allowOrientationList, //Set allowed Orientation List
  GeneralErrorHandle onFailed, //Set super onFailed
  FirebaseNotificationController
      firebaseNotificationController, //Enable FCM, will disable function if no object being pass
  BaseConstant
      constantFile, //Custom Base Constant, will have a default constant file if no object being pass
  AppTranslationX
      appLanguage, //Enable App Langauge, will disable function if no object being pass
  BaseX
      baseXConfig, //Custom Base Config, will have a default config file if no object being pass
  String title, //Set Project title
  ThemeData theme, //Set Project theme
  bool
      isLightMode, //Enable dark mode, if null being pass, will disable dark mode. Default value is null
  List<GetPage<dynamic>> getPages, //Register all page route
  @required BaseXWidget initialPage, //Set Initial Page
  Bindings initialBinding, //Set Global Binding
  Function additionalFunction, // Add additional function before runApp
  AddtionalWidget additionalWidget, // Add additional widget before material app
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
    additionalWidget: additionalWidget,
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
  final AddtionalWidget additionalWidget;
  const MyApp({
    this.title,
    this.theme,
    this.getPages,
    this.initialPage,
    this.initialBinding,
    this.appLanguage,
    this.isLightMode,
    this.additionalWidget,
  });

  Widget materialApp() {
    return GetMaterialApp(
      title: title,
      theme: isLightMode == null
          ? theme
          : theme.copyWith(brightness: Brightness.light),
      darkTheme: isLightMode == null
          ? null
          : theme.copyWith(brightness: Brightness.dark),
      themeMode: (isLightMode ?? true) ? ThemeMode.light : ThemeMode.dark,
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
