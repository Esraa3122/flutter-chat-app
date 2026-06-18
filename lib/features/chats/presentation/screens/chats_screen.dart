import 'package:e_chat/config/app/app_cubit/app_cubit.dart';
import 'package:e_chat/config/routes/app_routes.dart';
import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/core/utils/app_images.dart';
import 'package:e_chat/core/utils/date_helper.dart';
import 'package:e_chat/core/validations/app_validation.dart';
import 'package:e_chat/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:e_chat/features/chats/presentation/screens/widgets/chat_app_bar.dart';
import 'package:e_chat/features/chats/presentation/screens/widgets/chat_item.dart';
import 'package:e_chat/shared_widgets/custom_loading.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:e_chat/shared_widgets/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: chatAppBar(context, cubit),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: CustomTextFormFieldWidget(
                onChange: (value) {
                  context.read<GetChatsCubit>().searchChats(value);
                },
                textColor: context.color.textColor,
                hint: "search".tr(),
                hintColor: ColorsLight.hintColor,
                prefixIcon:
                    Icon(Icons.search, color: ColorsLight.mainTextColor),
                fillColor: context.color.chatBackgroundColor,
                validator: (String? value) {
                  AppValidator.noValidation();
                  return null;
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<GetChatsCubit, GetChatsState>(
                builder: (context, state) {
                  if (state is GetChatsLoading) {
                    return const CustomLoading();
                  }

                  if (state is GetChatsSuccess) {
                    final chats = state.chatsList;

                    if (chats.isEmpty) {
                      return Center(
                          child: Lottie.asset(AppImages.nonDataFound));
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
                          const myUid = 'user_me';

                          final friendId = chat.members?.firstWhere(
                                (id) => id != myUid,
                                orElse: () => "",
                              ) ??
                              "";

                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                AppRoutes.message,
                                extra: {
                                  'friendId': friendId,
                                  'roomId': chat.id,
                                  'chatsEntity': chat,
                                },
                              );
                            },
                            child: ChatsItem(
                              name: chat.friendName ?? "unknown".tr(),
                              image: chat.friendImage,
                              message: chat.lastMessage ?? '',
                              time: DateHelper.formatChatTime(
                                  chat.lastMessageTime),
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
            ),
          ],
        ),
      ),
    );
  }
}
