import 'package:flutter/material.dart';
import 'package:get/get.dart';

void changeDarkMode() {
  var context = Get.context;
  Get.changeThemeMode(context.isDarkMode ? ThemeMode.light : ThemeMode.dark);
}

Color setDarkModeColor(Color lightColor, Color darkColor) {
  BuildContext context = Get.context;
  return context.theme
      .copyWith(
          primaryColor:
              context.isDarkMode ? darkColor ?? lightColor : lightColor)
      .primaryColor;
}
