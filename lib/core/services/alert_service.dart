import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared_widgets/custom_text.dart';
import '../enum/alert_enum.dart';
import '../utils/app_colors.dart';

class AlertService {
  void showAlert({
    required BuildContext context,
    String? title,
    required String subtitle,
    required AlertStatus status,
  }) {

    final String finalTitle = title ?? 
        (status == AlertStatus.success ? "success".tr() : "error".tr());
        
    final Color accentColor = status == AlertStatus.success 
        ? ColorsLight.green 
        : ColorsLight.error;

    FToast().init(context).showToast(
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 5),
          child: Container(
            width: 350.w,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: context.color.popupMenu,
              border: Border.all(color: accentColor.withOpacity(0.2), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    status == AlertStatus.success ? Icons.check_circle_rounded : Icons.error_rounded,
                    color: accentColor,
                    size: 24.r,
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        text: finalTitle,
                        maxLines: 1,
                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: context.color.textColor, 
                            ),
                      ),
                      4.verticalSpace,
                      CustomTextWidget(
                        text: subtitle,
                        maxLines: 2,
                        textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12.sp,
                              color: ColorsLight.mainTextColor, 
                            ),
                      ),
                    ],
                  ),
                ),
                8.horizontalSpace,
                IconButton(
                  icon: Icon(Icons.close, size: 18.r, color: ColorsLight.mainTextColor),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => FToast().removeCustomToast(),
                ),
              ],
            ),
          ),
        );
  }
}