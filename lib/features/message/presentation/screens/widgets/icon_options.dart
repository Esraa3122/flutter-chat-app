import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconOptions extends StatelessWidget {
  const IconOptions(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressed});

  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsLight.blueLight1,
                  ColorsDark.blueLight2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
                icon,
                color: ColorsDark.white,
                size: FontDetails.fontSizeL,
              ),
            ),
        ),
        SizedBox(height: 8.h),
        CustomTextWidget(
          text: label,
          textStyle: TextStyle(
            color: context.color.textColor,
            fontSize: FontDetails.fontSizeXS,
            fontWeight: FontDetails.mediumFontWeight,
          ),
        ),
      ],
    );
  }
}
