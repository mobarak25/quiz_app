import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/colors.dart';

import 'text.dart';

class ButtonB extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color bgColor, borderColor;
  final double? heigh;
  final bool? shadow;
  final double? fontSize;
  final VoidCallback press;
  final bool loading;
  final FontWeight fontWeight;
  final double? horizontalPadding;
  final double? verticalPadding;

  const ButtonB(
      {Key? key,
      required this.text,
      this.textColor = bWhite,
      this.bgColor = bBrand,
      this.borderColor = Colors.transparent,
      this.heigh = 45,
      this.shadow = false,
      required this.press,
      this.fontSize = 17,
      this.fontWeight = FontWeight.w500,
      this.loading = false,
      this.horizontalPadding,
      this.verticalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: press,
        borderRadius: BorderRadius.circular(7),
        child: Ink(
          height: heigh,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: borderColor),
            boxShadow: shadow!
                ? const [
                    BoxShadow(
                      color: bWhite,
                      offset: Offset(-3.62, -2.41), //(x,y)
                      blurRadius: 4.83,
                    ),
                    BoxShadow(
                      color: Color(0xFFB9BCCB),
                      offset: Offset(2.41, 3.62), //(x,y)
                      blurRadius: 4.83,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextB(
                text: text!,
                fontColor: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              if (loading) const SizedBox(width: 10),
              if (loading)
                SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                        color: textColor, strokeWidth: 2.5))
            ],
          ),
        ),
      ),
    );
  }
}
