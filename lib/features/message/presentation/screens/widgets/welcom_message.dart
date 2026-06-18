import 'package:e_chat/config/themes/app_theme.dart';
import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeMessage extends StatelessWidget {
  final String roomId;
  final ChatsEntity chatsEntity;

  const WelcomeMessage({
    super.key,
    required this.roomId, required this.chatsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          final welcomeMsg = MessageEntity(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            message: "Hello👋",
            createdAt: DateTime.now(),
            fromId: 'user_me',
            type: "text",
            read: "sending",
            replyMessage: null,
          );

          context.read<MessageCubit>().sendMessage(welcomeMsg, roomId);
        },
        child: Card(
          color: ColorsDark.white.withOpacity(0.2),
          elevation: 3,
          shadowColor: context.color.textColor!.withOpacity(0.2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextWidget(
                    text: "👋",
                    textStyle: TextStyle(fontSize: FontDetails.fontSizeXL)),
                SizedBox(height: 10.h),
                CustomTextWidget(
                  text: "${"say_hello_to".tr()}${chatsEntity.friendName}",
                  textStyle: appTheme().textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
