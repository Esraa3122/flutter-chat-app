import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final int? maxLines;
  final TextStyle? textStyle;
  final bool? softWrap;

  const CustomTextWidget(
      {super.key,
      required this.text,
      this.textAlign = TextAlign.start,
      this.maxLines,
      this.textStyle, this.softWrap});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 2,
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
      softWrap: softWrap,
    );
  }
}
