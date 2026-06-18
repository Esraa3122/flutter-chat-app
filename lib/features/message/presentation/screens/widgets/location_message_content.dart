import 'package:e_chat/core/services/url_launcher_service.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationMessageContent extends StatelessWidget {
  const LocationMessageContent({
    super.key,
    required this.lat,
    required this.lng,
    required this.isMe,
    required this.address,
  });

  final String lat;
  final String lng;
  final bool isMe;
  final String address;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => UrlLauncherService().openMap(lat, lng),
      child: Container(
        width: 220.w,
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: isMe
              ? ColorsDark.white.withOpacity(0.15)
              : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Icon(Icons.location_on, color: ColorsDark.white),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    text: "live_location".tr(),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontDetails.fontSizeS,
                      color: isMe ? ColorsLight.white : ColorsLight.black,
                    ),
                  ),
                  CustomTextWidget(
                    text: address,
                    maxLines: 2,
                    textStyle: TextStyle(
                      fontSize: FontDetails.fontSizeXS,
                      color: isMe ? Colors.white70 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
