import 'package:flutter/material.dart';
import '../Utils/utils.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final Color textColor;
  final TextAlign? textAlign;
  final VoidCallback function;
  final int? maxLines;
  final bool invert;
  const CustomButton(
      {Key? key,
      required this.buttonColor,
      required this.text,
      this.textAlign,
      this.maxLines,
      this.textColor = Colors.black,
      required this.function,
      this.invert = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: invert == true
                ? Border.all(color: primaryColor, width: 1)
                : null,
            color: invert == true ? null : buttonColor),
        child: CustomText(
          text: text,
          color: textColor,
          textAlign: textAlign,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
