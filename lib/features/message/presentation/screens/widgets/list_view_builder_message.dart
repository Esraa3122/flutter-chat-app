import 'dart:io';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/date_helper.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:e_chat/features/message/presentation/screens/message_screen.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/message_buble.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swipe_to/swipe_to.dart';

class ListViewBuilderMessages extends StatelessWidget {
  const ListViewBuilderMessages({
    super.key,
    required this.messageCubit,
    required this.messages,
    required this.widget,
    required this.focusNode,
    this.pendingImagePath,
    required this.chatsEntity,
  });

  final MessageCubit messageCubit;
  final ChatsEntity chatsEntity;
  final List<MessageEntity> messages;
  final MessageScreen widget;
  final FocusNode focusNode;
  final String? pendingImagePath;

  @override
  Widget build(BuildContext context) {
    final hasPending = pendingImagePath != null && pendingImagePath!.isNotEmpty;
    final isTyping = messageCubit.state is MessageLoadedState &&
        (messageCubit.state as MessageLoadedState).isFriendTyping;
    final extraCount = (hasPending ? 1 : 0) + (isTyping ? 1 : 0);

    return ListView.builder(
      controller: messageCubit.controller0,
      reverse: true,
      itemCount: messages.length + extraCount,
      itemBuilder: (context, index) {
        if (isTyping && index == 0) {
          return Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: CustomTextWidget(
                text: "typing...".tr(),
                textStyle: TextStyle(
                    color: ColorsLight.blueLight1,
                    fontSize: FontDetails.fontSizeS,
                    fontStyle: FontStyle.italic),
              ),
            ),
          );
        }

        int pendingIndex = isTyping ? 1 : 0;

        if (hasPending && index == pendingIndex) {
          return _PendingImageBubble(path: pendingImagePath!);
        }

        final actualIndex = index - extraCount;
        final msg = messages[actualIndex];

        final time = DateHelper.formatMessageTime(msg.createdAt);
        bool showHeader = false;

        if (actualIndex == messages.length - 1) {
          showHeader = true;
        } else {
          final previousMessageTime = messages[actualIndex + 1].createdAt;
          if (msg.createdAt != null && previousMessageTime != null) {
            if (!DateHelper.isSameDay(msg.createdAt!, previousMessageTime)) {
              showHeader = true;
            }
          }
        }

        const myUid = 'user_me';

        bool isMe = msg.fromId == myUid;

        String messageStatus = msg.read ?? "sent";

        Widget messageWidget = SwipeTo(
          key: ValueKey(msg.id),
          onLeftSwipe: isMe ? (direction) => _handleSwipe(msg) : null,
          onRightSwipe: !isMe ? (direction) => _handleSwipe(msg) : null,
          child: isMe
              ? MessageBubleForMe(
                  type: msg.type ?? "text",
                  message: msg.message ?? "",
                  time: time,
                  status: messageStatus,
                  replyMessage: msg.replyMessage,
                  chatsEntity: chatsEntity,
                )
              : MessageBuble(
                  type: msg.type ?? "text",
                  message: msg.message ?? "",
                  time: time,
                  replyMessage: msg.replyMessage,
                  chatsEntity: chatsEntity,
                ),
        );

        if (showHeader && msg.createdAt != null) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorsDark.addMemberButtonLightBlue,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: CustomTextWidget(
                    text: DateHelper.getChatDayHeader(msg.createdAt!),
                    textStyle: TextStyle(
                      fontSize: 12.sp,
                      color: ColorsLight.mainTextColor,
                      fontWeight: FontDetails.boldFontWeight,
                    ),
                  ),
                ),
              ),
              messageWidget,
            ],
          );
        }
        return messageWidget;
      },
    );
  }

  void _handleSwipe(MessageEntity msg) {
    messageCubit.selectReplyMessage(msg);
    focusNode.requestFocus();
  }
}

class _PendingImageBubble extends StatelessWidget {
  final String path;
  const _PendingImageBubble({required this.path});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.all(6.r),
        margin:
            const EdgeInsetsDirectional.only(end: 16, start: 60, bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xff1565C0),
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(16.r),
            topEnd: Radius.circular(16.r),
            bottomStart: Radius.circular(16.r),
            bottomEnd: Radius.circular(4.r),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.file(
                File(path),
                width: 200.w,
                height: 200.w,
                fit: BoxFit.cover,
              ),
              Container(
                width: 200.w,
                height: 200.w,
                color: Colors.black.withOpacity(0.45),
              ),
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: const CircularProgressIndicator(
                  color: ColorsDark.white,
                  strokeWidth: 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
