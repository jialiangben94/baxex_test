import 'package:baxex_test/app/ui/common_widget/dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(
    BuildContext context, String title, String desc,
    {String confirmText}) async {
  return await showDialog(
          context: context,
          builder: (dContext) {
            return ConfirmDialog(
              title,
              desc,
              confirmText: confirmText,
            );
          }) ??
      false;
}
