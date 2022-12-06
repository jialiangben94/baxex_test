import 'dart:developer';

import 'package:baseX/baseX.dart';
import 'package:baseX/helper/dark_mode_controller.dart';
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
      color: colorBlackWhite,
      child: Center(
          child: Column(
        children: [
          Text(
            "Text",
            style: regular(16, colorWhiteBlack),
          ),
          Text(
            "Text",
            style: regular(16, color_a5a5a5),
          ),
          SizedBox(height: 30),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: colorWhiteBlack),
              onPressed: () {
                log(context.isDarkMode.toString());
                changeDarkMode();
              },
              child: Text(
                "Change theme",
                style: regular(16, colorBlackWhite),
              )),
        ],
      )),
    );
  }
}
