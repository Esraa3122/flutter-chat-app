import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget(
      {super.key,
      required this.hint,
      this.suffixIcon,
      this.obscureText = false,
      this.withBorders = false,
      this.readOnly = false,
      this.textInputType,
      this.textInputAction,
      this.textAlign = TextAlign.start,
      this.fillColor,
      this.labelColor,
      this.hintColor,
      this.textColor,
      this.controller,
      this.onChange,
      required this.validator,
      this.prefixIcon,
      this.onEditingComplete,
      this.focusNode,
      this.maxLength,
      this.fontSize,
      this.fontWeight});

  final TextEditingController? controller;
  final String hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool obscureText;
  final bool withBorders;
  final TextAlign textAlign;
  final FormFieldValidator<String> validator;
  final bool readOnly;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? textColor;
  final void Function(String)? onChange;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          maxLength: maxLength,
          focusNode: focusNode,
          readOnly: readOnly,
          obscureText: obscureText,
          controller: controller,
          keyboardType: textInputType,
          maxLines: obscureText ? 1 : null,
          textInputAction: textInputAction,
          onChanged: onChange,
          textAlign: textAlign,
          textAlignVertical: TextAlignVertical.center,
          validator: validator,
          cursorColor: ColorsDark.blueDark,
          onEditingComplete: onEditingComplete,
          style: TextStyle(
            color: textColor ?? context.color.textColor,
            fontSize: fontSize ?? FontDetails.fontSizeS,
            fontWeight: fontWeight ?? FontDetails.mediumFontWeight,
          ),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hint,
            hintStyle: TextStyle(
              color: hintColor ?? ColorsLight.hintColor,
            ),
            filled: fillColor != null,
            fillColor: fillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            border: withBorders
                ? OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorsLight.mainTextColor, width: 0.5.w),
                    borderRadius: BorderRadius.circular(20.r),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
            focusedBorder: withBorders
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsDark.blueDark, width: 0.5.w),
                    borderRadius: BorderRadius.circular(20.r),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
            errorBorder: withBorders
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsLight.error, width: 0.5.w),
                    borderRadius: BorderRadius.circular(22.r),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
            focusedErrorBorder: withBorders
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorsLight.error, width: 0.5.w),
                    borderRadius: BorderRadius.circular(20.r),
                  )
                : OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
          ),
        )
      ],
    );
  }
}
