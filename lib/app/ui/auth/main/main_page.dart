import 'package:baseX/baseX.dart';
import 'package:baxex_test/app/ui/auth/main/main_controller.dart';
import 'package:baxex_test/app/ui/menu/menu/menu_page.dart';
import 'package:baxex_test/app/util/export.dart';
import 'package:flutter/material.dart';

class MainPage extends BaseXWidget<MainController> with CustomTextStyle {
  @override
  Widget? appBar(BuildContext context) {
    // TODO: implement appBar
    return null;
  }

  @override
  bool get safeArea => true;

  @override
  Widget? body(BuildContext context) {
    // TODO: implement body
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.red,
      child: Center(
        child: TextButton(
          child: Text("Next"),
          onPressed: () => loadPage(MenuPage()),
        ),
      ),
    );
  }

  @override
  // TODO: implement routeName
  String get routeName => "/main";
}
