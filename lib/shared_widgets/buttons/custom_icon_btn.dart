import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  const CustomIconBtn(
      {super.key,
      required this.onPressed,
      this.style,
      required this.text,
      this.textStyle, required this.icon});

  final VoidCallback onPressed;
  final ButtonStyle? style;
  final String text;
  final TextStyle? textStyle;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: CustomTextWidget(
        text: text,
        textStyle: textStyle ??
            Theme.of(context).outlinedButtonTheme.style!.textStyle!.resolve({}),
      ),
      style: style ?? Theme.of(context).elevatedButtonTheme.style,
      onPressed: onPressed,
    );
  }
}
