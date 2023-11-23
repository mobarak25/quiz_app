import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/text_styles.dart';

class TextB extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final double? fontHeight;
  final TextAlign? alignMent;
  final int? maxLines;
  final TextDecoration? decoration;

  const TextB({
    Key? key,
    required this.text,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    this.textStyle = bStyle,
    this.fontHeight,
    this.alignMent,
    this.maxLines,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.visible,
      style: TextStyle(
        height: fontHeight ?? textStyle!.height,
        fontSize: fontSize ?? textStyle!.fontSize,
        color: fontColor ?? textStyle!.color,
        fontWeight: fontWeight ?? textStyle!.fontWeight,
        decoration: decoration,
      ),
      textAlign: alignMent ?? TextAlign.start,
    );
  }
}
