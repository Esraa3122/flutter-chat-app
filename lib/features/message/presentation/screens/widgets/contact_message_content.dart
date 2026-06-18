import 'package:e_chat/core/services/url_launcher_service.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactMessageContent extends StatelessWidget {
  const ContactMessageContent({
    super.key,
    required this.isMe,
    required this.contactData,
  });

  final bool isMe;
  final Map<String, dynamic> contactData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230.w,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color:
            isMe ? ColorsDark.white.withOpacity(0.15) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isMe ? ColorsDark.white : ColorsLight.blueLight1,
            child: Icon(
              Icons.person,
              color: isMe ? ColorsDark.bublechat : ColorsDark.white,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: contactData['name'] ?? "",
                  textStyle: TextStyle(
                    color: isMe ? ColorsLight.white : ColorsLight.black,
                    fontWeight: FontWeight.bold,
                    fontSize: FontDetails.fontSizeS,
                  ),
                ),
                CustomTextWidget(
                  text: contactData['phone'] ?? "",
                  textStyle: TextStyle(
                    color: isMe ? Colors.white70 : Colors.black54,
                    fontSize: FontDetails.fontSizeXS,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.call,
                color: isMe ? ColorsLight.white : ColorsLight.blueLight1,
              ),
              onPressed: () =>
                  UrlLauncherService().callPhone(contactData['phone'] ?? ""))
        ],
      ),
    );
  }
}
