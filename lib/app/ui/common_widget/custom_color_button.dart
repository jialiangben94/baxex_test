import 'package:baxex_test/app/util/export.dart';
import 'package:flutter/material.dart';

class CustomColorButton extends StatelessWidget with CustomTextStyle {
  final String title;
  final Color titleColor;
  final Color color;
  final double height;
  final Function()? onTap;
  const CustomColorButton(this.title, this.onTap,
      {this.height = 40,
      this.titleColor = colorWhite,
      this.color = themeColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            // BoxShadow(color: colorBlack.withOpacity(0.25), offset: const Offset(0, 4), blurRadius: 4)
          ]),
      child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            minimumSize:
                MaterialStateProperty.all(const Size(double.infinity, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            // elevation: MaterialStateProperty.all(3),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Text(
            title,
            style: regular(14, titleColor),
            textAlign: TextAlign.center,
          )),
    );
  }
}
