import 'package:flutter/material.dart';
import 'package:get/get.dart';

void changeDarkMode() {
  var context = Get.context;
  if (context == null) return;
  Get.changeThemeMode(context.isDarkMode ? ThemeMode.light : ThemeMode.dark);
}

/// Light Color, Dark Color
Color setDarkModeColor(Color lightColor, Color darkColor) {
  BuildContext? context = Get.context;
  if (context == null) return lightColor;
  return context.theme
      .copyWith(primaryColor: context.isDarkMode ? darkColor : lightColor)
      .primaryColor;
}
