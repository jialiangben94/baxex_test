import 'dart:developer';

import 'package:baseX/baseX.dart';
import 'package:baseX/helper/dark_mode_controller.dart';
import 'package:baxex_test/app/config/custom_share_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends BaseXController {
  TextEditingController form = TextEditingController();
  RxString prefValue = "".obs;
  bool isloader = false;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    fetchData();
  }

  @override
  void onFailedDialog(int code, String msg, data) {
    // TODO: implement dialogFailed
    super.onFailedDialog(code, msg, data);
    // var isErorr =false;
  }

  @override
  bool onFailed(int code, String msg, data, {Function? tryAgain}) {
    return super.onFailed(code, msg, data, tryAgain: tryAgain);
  }

  fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    onFailed(300, "Error Message showed", null);
  }

  onChangeTheme(BuildContext context) {
    log(context.isDarkMode.toString());
    changeDarkMode();
  }

  onSavePref(BuildContext context) async {
    await CustomSharePref().saveTest(form.text);
    showDialog(
        context: context,
        builder: (dContext) => AlertDialog(title: Text("Success Saved")));
  }

  onShowPref() {
    prefValue.value = CustomSharePref().test;
  }

  onRemovePref(BuildContext context) async {
    await CustomSharePref().removeTest();
    showDialog(
        context: context,
        builder: (dContext) => AlertDialog(title: Text("Success Removed")));
  }

  @override
  Future<bool> onBack() async => true;
}
