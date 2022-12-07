import 'package:baseX/helper/dark_mode_controller.dart';
import 'package:flutter/material.dart';

const themeColor = Color(0xFFA81E33);
const themeBackground = Color(0xFFFAF8F6);

const colorWhite = Colors.white;
const colorWhite70 = Colors.white70;
const colorBlack = Colors.black;
const colorTransparent = Colors.transparent;
const colorBlack12 = Colors.black12;
const colorBlack26 = Colors.black26;

const color_a5a5a5 = Color(0xFFA5A5A5);

Color get colorBlackWhite => setDarkModeColor(Colors.black, Colors.white);
Color get colorWhiteBlack => setDarkModeColor(Colors.white, Colors.black);
