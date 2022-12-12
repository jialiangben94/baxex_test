import 'package:baxex_test/app/ui/common_widget/custom_color_button.dart';
import 'package:baxex_test/app/util/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget with CustomTextStyle {
  final String? title;
  final String? desc;
  final String? confirmText;
  const ConfirmDialog(this.title, this.desc, {this.confirmText = "Confirm"});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Material(
            color: colorTransparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  if ((title ?? "").isNotEmpty)
                    Text(
                      title ?? "",
                      style: regularSemi(20, colorBlack),
                      textAlign: TextAlign.center,
                    ),
                  if ((title ?? "").isNotEmpty) SizedBox(height: 20),
                  if ((desc ?? "").isNotEmpty)
                    Text(
                      desc ?? "",
                      style: regular(16, colorBlack),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(height: 25),
                  CustomColorButton(
                      confirmText ?? "Confirm", () => Get.back(result: true))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
