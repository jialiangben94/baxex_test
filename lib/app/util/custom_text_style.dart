import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin CustomTextStyle {
  //Regular Font
  TextStyle regular(double fontSize, Color color,
      {TextDecoration decoration, double height, Color darkColor}) {
    BuildContext context = Get.context;
    return TextStyle(
        color: context.theme
            .copyWith(
                primaryColor: context.isDarkMode ? darkColor ?? color : color)
            .primaryColor,
        fontSize: fontSize,
        decoration: decoration ?? TextDecoration.none,
        height: height);
  }

  TextStyle regularItalic(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      TextStyle(
          color: color,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          decoration: decoration ?? TextDecoration.none,
          height: height);

  TextStyle regularSemi(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          decoration: decoration ?? TextDecoration.none,
          height: height);

  TextStyle regularSemiItalic(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      TextStyle(
          color: color,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          decoration: decoration ?? TextDecoration.none,
          height: height);

  TextStyle regularBold(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          decoration: decoration ?? TextDecoration.none,
          height: height);

  TextStyle regularBoldItalic(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      TextStyle(
          color: color,
          fontSize: fontSize,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w700,
          decoration: decoration ?? TextDecoration.none,
          height: height);
}
