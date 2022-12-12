import 'dart:io';

import 'package:baseX/baseX.dart';
import 'package:baseX/helper/scroll_behaviour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hms_gms_checker/flutter_hms_gms_checker.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';
import 'package:flutter/foundation.dart';

import 'base_x_controller.dart';

class DefaulBaseX extends BaseX {}

abstract class BaseX {
  /// Set a default background color if needed, default value is `Colors.white`.
  Color get defaultBackgroundColor => Colors.white;

  // Set a default loading widget if needed.
  Widget get defaultLoadingWidget => SizedBox.shrink();

  //set the statusBarText into white, default false(black).
  bool get statusBarTextWhiteColor => false;

  Widget customErrorWidget(FlutterErrorDetails error) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Icon(Icons.announcement, size: 40, color: Colors.red)),
          Text(
            'An application error has occurred.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Error message:',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline)),
                  Text(error.exceptionAsString()),
                ],
              )),
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Stack Trace:',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline)),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Text(error.stack.toString()))),
                  ],
                )),
          ),
          Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              child: InkWell(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text('Send Bug Report',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ))),
                ),
              )),
        ]),
      ),
    );
  }

  Future<void> defaulOnFailedDialog(String message) => Get.dialog(AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Text(message),
      ));

  Future<double> getSystemBottomSafeAreaHeight(
      {bool forceAndroidZero = true}) async {
    return (Get.mediaQuery.viewPadding.bottom > 15.0
        ? 15.0
        : Get.mediaQuery.viewPadding.bottom);
  }

  // GeneralErrorHandle onFailed =
  //     ((BuildContext context, code, msg, {tryAgain}) => null);
}

typedef GeneralErrorHandle = bool
    Function(BuildContext context, int code, String msg, {Function? tryAgain});

typedef GeneralErrorHandleConfig = bool Function(
    BuildContext context, int code, String msg);

typedef OnFailed = bool Function(int code, String message, dynamic data,
    {Function() tryAgain});

abstract class BaseXWidget<T extends BaseXController> extends GetWidget<T> {
  T get c => controller;

  String get routeName;

  bool get safeArea => true;

  bool get resizeToAvoidBottomInset => false;

  Color get backgroundColor => baseXWidgetConfig.defaultBackgroundColor;

  Widget? loader() => baseXWidgetConfig.defaultLoadingWidget;

  Widget? appBar(BuildContext context);

  Widget? body(BuildContext context);

  Widget? overlayChild() => null;

  Widget _contentBody(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (appBar(context) != null) appBar(context)!,
            if (body(context) != null)
              Expanded(
                child: hideScrollShadow(body(context)!),
              ),
          ],
        ),
        if (overlayChild() != null) Positioned.fill(child: overlayChild()!),
        Obx(() => controller.isLoading.value
            ? (loader() ?? SizedBox.shrink())
            : SizedBox.shrink()),
        if (kDebugMode && routeName.isNotEmpty) _topTag()
      ],
    );
  }

  Widget _topTag() {
    return Positioned(
      left: 5,
      top: 20.0 + (safeArea ? 0 : Get.mediaQuery.viewPadding.top),
      child: IgnorePointer(
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(330 / 360),
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              routeName.replaceAll('/', ''),
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _scaffoldChild(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      body: KeyboardDismissOnTap(
        dismissOnCapturedTaps: true,
        child: safeArea
            ? SafeArea(child: _contentBody(context))
            : _contentBody(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _scaffoldChild(context)
        : WillPopScope(
            onWillPop: controller.onBack, child: _scaffoldChild(context));
  }
}
