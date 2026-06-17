import 'package:e_chat/config/app/app_cubit/app_cubit.dart';
import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/app_images.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/core/widgets/custom_day_night_switch.dart';
import 'package:e_chat/core/widgets/language_switcher.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget chatAppBar(BuildContext context, AppCubit cubit) {
  return PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: AppBar(
        backgroundColor: context.color.mainColor,
        flexibleSpace: Image.asset(
          AppImages.bG,
          fit: BoxFit.cover,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(8.h),
          child: CustomTextWidget(
            text: "E-Chat",
            textStyle: TextStyle(
                color: ColorsLight.white,
                fontSize: FontDetails.fontSizeL,
                fontWeight: FontDetails.boldFontWeight),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.h),
            child: LanguageSwitcher(),
          ),
          Padding(
            padding: EdgeInsets.all(8.h),
            child: CustomDayNightSwitch(cubit: cubit),
          ),
        ],
      ));
}
