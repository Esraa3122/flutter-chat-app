import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/shared_widgets/buttons/elevated_btn_widget.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class CustomDialog {
  const CustomDialog._();

  static void twoButtonDialog({
    required BuildContext context,
    required String textBody,
    required String textButton1,
    required String textButton2,
    required void Function() onPressed,
    required bool isLoading,
  }) {
    showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsLight.mainTextColor,
        title: Padding(
          padding: EdgeInsets.only(
            top: 30.h,
            bottom: 20.h,
          ),
          child: Center(
            child: CustomTextWidget(
              text: textBody,
              textStyle: TextStyle(
                fontWeight: FontDetails.mediumFontWeight,
                fontSize: 18.sp,
                color: ColorsLight.black,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        actions: [
          CustomElevatedButtonWidget(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsLight.red, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed,
            text: textButton1,
            textStyle: const TextStyle(color: ColorsDark.white),
            btnWidth: 320.w,
            btnHeight: 45.h,
          ),
          SizedBox(height: 10.h, width: 1.w),
          CustomElevatedButtonWidget(
            onPressed: () {
              GoRouter.of(context).pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            text: textButton2,
            textStyle: const TextStyle(color: ColorsDark.white),
            btnWidth: 320.w,
            btnHeight: 45.h,
          ),
        ],
      ),
    );
  }
}
