import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/message_content.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/reply_message_widget.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBuble extends StatelessWidget {
  final String message;
  final ChatsEntity chatsEntity;
  final String time;
  final MessageEntity? replyMessage;
  final String type;

  const MessageBuble({
    super.key,
    required this.message,
    required this.time,
    required this.replyMessage,
    required this.type, required this.chatsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin:
            const EdgeInsetsDirectional.only(start: 16, end: 60, bottom: 12),
        decoration: BoxDecoration(
          color: ColorsDark.white,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(16.r),
            topEnd: Radius.circular(16.r),
            bottomEnd: Radius.circular(16.r),
            bottomStart: Radius.circular(4.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (replyMessage != null) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border(
                    left: BorderSide(
                      color: ColorsLight.blueLight1,
                      width: 4.w,
                    ),
                  ),
                ),
                child: ReplyMessageWidget(
                  message: replyMessage!,
                  friendName: chatsEntity.friendName ??"friend".tr(),
                ),
              ),
              SizedBox(height: 8.h),
            ],
            MessageContent(
              type: type,
              message: message,
              isMe: false,
            ),
            SizedBox(height: 6.h),
            CustomTextWidget(
              text: time,
              textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: FontDetails.fontSizeXS),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubleForMe extends StatelessWidget {
  final String message;
  final String time;
  final String status;
  final String type;
  final MessageEntity? replyMessage;
  final ChatsEntity chatsEntity;

  const MessageBubleForMe({
    super.key,
    required this.message,
    required this.time,
    required this.status,
    required this.replyMessage,
    required this.type, required this.chatsEntity,
  });

  Widget _buildStatusIcon() {
    switch (status) {
      case 'sending':
        return Icon(Icons.access_time, color: Colors.white70, size: 14.sp);
      case 'sent':
        return Icon(Icons.check, color: Colors.white70, size: 16.sp);
      case 'delivered':
        return Icon(Icons.done_all, color: Colors.white70, size: 16.sp);
      case 'read':
        return Icon(Icons.done_all, color: ColorsLight.blueLight1, size: 16.sp);
      default:
        return Icon(Icons.check, color: Colors.white70, size: 16.sp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        margin:
            const EdgeInsetsDirectional.only(end: 16, start: 60, bottom: 12),
        decoration: BoxDecoration(
          color: ColorsDark.bublechat,
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(16.r),
            topEnd: Radius.circular(16.r),
            bottomStart: Radius.circular(16.r),
            bottomEnd: Radius.circular(4.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (replyMessage != null) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                margin: EdgeInsets.only(bottom: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border(
                    left: BorderSide(
                      color: ColorsLight.blueLight1,
                      width: 4.w,
                    ),
                  ),
                ),
                child: ReplyMessageWidget(
                  message: replyMessage!,
                  friendName: chatsEntity.friendName ?? "friend".tr(),
                ),
              ),
              SizedBox(height: 8.h),
            ],
            MessageContent(
              type: type,
              message: message,
              isMe: true,
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                  text: time,
                  textStyle: TextStyle(
                      color: Colors.white70, fontSize: FontDetails.fontSizeXS),
                ),
                SizedBox(width: 4.w),
                _buildStatusIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
