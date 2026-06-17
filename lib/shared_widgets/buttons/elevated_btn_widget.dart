import 'package:flutter/material.dart';

import '../custom_text.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget(
      {super.key,
        required this.btnWidth,
        required this.btnHeight,
        required this.text,
        required this.onPressed,
        this.style,
        this.textStyle});

  final double btnWidth;
  final double btnHeight;
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style ?? Theme.of(context).elevatedButtonTheme.style,
        child: CustomTextWidget(
          text: text,
          textStyle: textStyle ?? Theme.of(context).elevatedButtonTheme.style!.textStyle!.resolve( {}),
        ),
      ),
    );
  }
}