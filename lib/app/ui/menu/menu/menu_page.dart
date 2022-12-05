import 'dart:developer';

import 'package:baseX/baseX.dart';
import 'package:baxex_test/app/util/export.dart';
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
      color: Colors.white,
      child: Center(
          child: Column(
        children: [
          Text(
            "Text",
            style: regular(16, Colors.blue, darkColor: Colors.black),
          ),
          SizedBox(height: 30),
          TextButton(
              onPressed: () {
                log(context.isDarkMode.toString());
                Get.changeThemeMode(
                    context.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
              child: Text("Change theme")),
        ],
      )),
    );
  }
}
