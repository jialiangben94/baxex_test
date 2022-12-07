import 'package:baseX/helper/dark_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin CustomTextStyle {
  TextStyle _theme(double fontSize, Color color, FontWeight fontWeight,
      {FontStyle fontStyle, TextDecoration decoration, double height}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle ?? FontStyle.normal,
        decoration: decoration ?? TextDecoration.none,
        height: height);
  }

  //Regular Font
  TextStyle regular(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      _theme(fontSize, color, FontWeight.normal,
          decoration: decoration, height: height);

  TextStyle regularItalic(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      _theme(fontSize, color, FontWeight.normal,
          fontStyle: FontStyle.italic, decoration: decoration, height: height);

  TextStyle regularSemi(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      _theme(fontSize, color, FontWeight.w500,
          decoration: decoration, height: height);

  TextStyle regularSemiItalic(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      _theme(fontSize, color, FontWeight.w500,
          fontStyle: FontStyle.italic, decoration: decoration, height: height);

  TextStyle regularBold(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      _theme(fontSize, color, FontWeight.w700,
          decoration: decoration, height: height);

  TextStyle regularBoldItalic(double fontSize, Color color,
          {TextDecoration decoration, double height}) =>
      _theme(fontSize, color, FontWeight.w700,
          fontStyle: FontStyle.italic, decoration: decoration, height: height);
}
