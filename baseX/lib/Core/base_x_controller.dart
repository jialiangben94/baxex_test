import 'package:baseX/baseX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';

GeneralErrorHandle onFailed =
    ((BuildContext context, code, msg, {tryAgain}) => true);

/// onFailedDialog => Function will run when super.onFailed return false, by default will show a dialog set in BaseConfig file.
///
/// onFailed => onFailed function for api, by default will run onFailedDialog.
abstract class BaseXController<T> extends FullLifeCycleController
    with FullLifeCycleMixin
    implements GeneralCallBack, RequiredCallBack {
  RxBool isLoading = false.obs;
  T page = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    setStatusBarColor(null);
  }

  @override
  void onClose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        baseXWidgetConfig.statusBarTextWhiteColor);
    super.onClose();
  }

  @override
  void onDetached() {
    print('$runtimeType - onDetached called');
  }

  @override
  void onInactive() {
    print('$runtimeType - onInactive called');
  }

  @override
  void onPaused() {
    print('$runtimeType - onPaused called');
  }

  @override
  void onResumed() {
    print('$runtimeType - onResumed called');
  }

  Future<void> setStatusBarColor(bool isWhite) async {
    await FlutterStatusbarcolor.setStatusBarWhiteForeground(
        isWhite ?? baseXWidgetConfig.statusBarTextWhiteColor);
  }

  void onFailedDialog(int code, String msg, dynamic data) {
    if (!Get.isDialogOpen) {
      baseXWidgetConfig.defaulOnFailedDialog(msg);
    }
  }

  @override
  bool onFailed(int code, String msg, dynamic data, {Function() tryAgain}) {
    isLoading.value = false;
    // dismissKeyboard(Get.context);
    if (!(baseConstant.onFailed(Get.context, code, msg) ?? false)) {
      onFailedDialog(code, msg, data);
    }
    return true;
  }
}

abstract class GeneralCallBack {
  bool onFailed(int code, String msg, dynamic data, {Function() tryAgain});
}

abstract class RequiredCallBack {
  Future<bool> onBack() async => true;
}
