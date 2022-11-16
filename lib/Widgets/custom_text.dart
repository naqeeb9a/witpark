import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontsize;
  final int? maxLines;
  final TextAlign? textAlign;
  const CustomText(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w500,
      this.fontsize = 13,
      this.textAlign,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontsize,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
