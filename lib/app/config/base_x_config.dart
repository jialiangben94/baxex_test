import 'package:baseX/baseX.dart';
import 'package:baxex_test/app/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseXConfig extends BaseX {
  @override
  Widget get defaultLoadingWidget => const Center(
          child: CircularProgressIndicator(
        color: Colors.black,
      ));

  @override
  Future<void> defaulOnFailedDialog(String message) async {
    if (Get.context == null) return;
    await showConfirmationDialog(Get.context!, "Error", message);
    return;
  }

  @override
  // TODO: implement statusBarTextWhiteColor
  bool get statusBarTextWhiteColor => true;
}
