import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar AppBarMessage(BuildContext context, MessageCubit cubit, String roomId) {
  return AppBar(
    backgroundColor: context.color.mainColor,
    scrolledUnderElevation: 0,
    automaticallyImplyLeading: false,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: CustomTextWidget(
      text: 'message'.tr(),
      textStyle: TextStyle(
        color: context.color.textColor,
        fontWeight: FontDetails.boldFontWeight,
        fontSize: 20.sp,
      ),
    ),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsDark.white.withOpacity(0.4),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: ColorsLight.mainTextColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back_rounded,
              color: context.color.textColor, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    ),
  );
}