import 'package:flutter/material.dart';

class MyBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return ClampingScrollPhysics();
  }

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Widget hideScrollShadow(Widget child){
  return ScrollConfiguration(
    behavior: MyBehavior(),
    child: child,
  );
}