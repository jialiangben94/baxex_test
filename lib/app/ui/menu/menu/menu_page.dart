import 'dart:developer';

import 'package:baseX/baseX.dart';
import 'package:baseX/helper/dark_mode_controller.dart';
import 'package:baxex_test/app/config/custom_share_pref.dart';
import 'package:baxex_test/app/util/export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baxex_test/app/ui/menu/menu/menu_controller.dart';
import 'package:get/get.dart';

class MenuPage extends BaseXWidget<MenuController> with CustomTextStyle {
  @override
  String get routeName => '/menu';

  @override
  Widget appBar(BuildContext context) => null;

  @override
  MenuController get c => controller;

  @override
  Widget body(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colorWhiteBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Text",
              style: regular(16, colorBlackWhite),
            ),
            Obx(
              () => Text(
                c.prefValue.value,
                style: regular(16, color_a5a5a5),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: c.form,
              style: regular(16, colorBlackWhite),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colorBlackWhite),
                onPressed: () => c.onChangeTheme(context),
                child: Text(
                  "Change theme",
                  style: regular(16, colorWhiteBlack),
                )),
            SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colorBlackWhite),
                onPressed: () => c.onSavePref(context),
                child: Text(
                  "Save Prefs",
                  style: regular(16, colorWhiteBlack),
                )),
            SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colorBlackWhite),
                onPressed: c.onShowPref,
                child: Text(
                  "Show Prefs",
                  style: regular(16, colorWhiteBlack),
                )),
            SizedBox(height: 30),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colorBlackWhite),
                onPressed: () => c.onRemovePref(context),
                child: Text(
                  "Remove Prefs",
                  style: regular(16, colorWhiteBlack),
                )),
          ],
        ),
      ),
    );
  }
}
