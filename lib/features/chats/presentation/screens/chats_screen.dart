import 'package:e_chat/config/app/app_cubit/app_cubit.dart';
import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/app_images.dart';
import 'package:e_chat/core/utils/date_helper.dart';
import 'package:e_chat/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:e_chat/features/chats/presentation/screens/widgets/chat_app_bar.dart';
import 'package:e_chat/features/chats/presentation/screens/widgets/chat_item.dart';
import 'package:e_chat/shared_widgets/custom_loading.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return Scaffold(
      appBar: chatAppBar(context, cubit),
      body: BlocBuilder<GetChatsCubit, GetChatsState>(
        builder: (context, state) {
          if (state is GetChatsLoading) {
            return const CustomLoading();
          }
          if (state is GetChatsSuccess) {
            final chats = state.chatsList;
            if (chats.isEmpty) {
              return Center(child: Lottie.asset(AppImages.bgEmptyChatScreen));
            }
            return RefreshIndicator(
              backgroundColor: context.color.popupMenu,
              color: ColorsDark.blueLight2,
              onRefresh: () async {
                await context.read<GetChatsCubit>().fetchChats();
              },
              child: ListView.builder(
                itemCount: chats.length,
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  return GestureDetector(
                    onTap: () {
                      // TODO: Messege Screen
                    },
                    child: ChatsItem(
                      name: chat.friendName ?? "unknown".tr(),
                      image: chat.friendImage,
                      message: chat.lastMessage ?? '',
                      time: DateHelper.formatChatTime(chat.lastMessageTime),
                      unreadCount: chat.unreadCount ?? 0,
                    ),
                  );
                },
              ),
            );
          }

          if (state is GetChatsError) {
            return Center(child: CustomTextWidget(text: state.errMsg));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
