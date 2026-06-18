import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarMessage2 extends StatelessWidget {
  final ChatsEntity chatsEntity;
  const AppBarMessage2({super.key, required this.chatsEntity,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.color.mainColor,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: context.color.circleAvatarBackgroundColor,
            child: 
            (chatsEntity.friendImage != null &&
                    chatsEntity.friendImage!.isNotEmpty)
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: chatsEntity.friendImage!,
                      width: 52.r,
                      height: 52.r,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CustomTextWidget(
                          text: chatsEntity.friendName!.isNotEmpty
                              ? chatsEntity.friendName![0].toUpperCase()
                              : '',
                          textStyle: TextStyle(
                              color: ColorsLight.white, fontSize: 20.sp),
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: CustomTextWidget(
                          text: chatsEntity.friendName!.isNotEmpty
                              ? chatsEntity.friendName![0].toUpperCase()
                              : '',
                          textStyle: TextStyle(
                              color: ColorsLight.white, fontSize: 20.sp),
                        ),
                      ),
                    ),
                  )
                : 
                CustomTextWidget(
                    text: chatsEntity.friendName!.isNotEmpty ? chatsEntity.friendName![0].toUpperCase(): '',
                    textStyle:
                        TextStyle(color: ColorsLight.white, fontSize: 20.sp),
                  ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: chatsEntity.friendName!,
                  textStyle: TextStyle(
                      color: context.color.textColor,
                      fontWeight: FontDetails.boldFontWeight,
                      fontSize: 16.sp),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomTextWidget(
                    text:
                        '(${chatsEntity.countryCode}) ${chatsEntity.phone}',
                    textStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: FontDetails.fontSizeXS),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
