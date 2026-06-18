import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/font_details.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:e_chat/features/message/presentation/screens/message_screen.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/reply_message_widget.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/send_icon.dart';
import 'package:e_chat/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendingMessagesContainer extends StatelessWidget {
  const SendingMessagesContainer({
    super.key,
    required this.widget,
    required this.focusNode, required this.chatsEntity,
  });

  final MessageScreen widget;
  final FocusNode focusNode;
  final ChatsEntity chatsEntity;

  @override
  Widget build(BuildContext context) {
    final messageCubit = context.read<MessageCubit>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      color: context.color.mainColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<MessageCubit, MessageState>(
            buildWhen: (previous, current) => current is MessageLoadedState,
            builder: (context, state) {
              if (state is MessageLoadedState && state.replyMessage != null) {
                final MessageEntity currentReply = state.replyMessage!;
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      color: context.color.textColor!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border(
                        left: BorderSide(
                          color: ColorsLight.blueLight1,
                          width: 4.w,
                        ),
                      ),
                    ),
                    child: ReplyMessageWidget(
                      message: currentReply, 
                      friendName: chatsEntity.friendName ?? "friend".tr(),
                      onCancelReply: () => messageCubit.cancelReply(),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorsDark.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: context.color.mainColor!.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    context.read<MessageCubit>().toggleMenu();
                  },
                  icon: Icon(Icons.add,
                      color: ColorsLight.blueLight1,
                      size: FontDetails.fontSizeL),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomTextFormFieldWidget(
                  fillColor: ColorsLight.mainTextColor.withOpacity(0.1),
                  controller: messageCubit.controller,
                  textInputType: TextInputType.multiline,
                  focusNode: focusNode,
                  hint: 'type_a_message'.tr(),
                  hintColor: ColorsLight.mainTextColor,
                  withBorders: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Enter messege";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 12.w),
              InkWell(
                onTap: () {
                  messageCubit.sendTextMessage(
                      roomId: widget.roomId, friendId: widget.friendId);
                },
                child: const SendIcon(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}