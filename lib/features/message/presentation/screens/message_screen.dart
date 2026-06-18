import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/network/connectivity_cubit/connectivity_cubit.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/app_bar_message.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/app_bar_message2.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/attachmenu_menu.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/list_view_builder_message.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/sending_messages_container.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/welcom_message.dart';
import 'package:e_chat/shared_widgets/custom_loading.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatefulWidget {
  final String roomId;
  final String friendId;
  final ChatsEntity chatsEntity;
  const MessageScreen({
    super.key,
    required this.roomId,
    required this.friendId,
    required this.chatsEntity,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late MessageCubit messageCubit;
  MessageEntity? replyMessage;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    messageCubit = context.read<MessageCubit>();
    messageCubit.initChat(widget.roomId, widget.friendId);
  }

  @override
  void dispose() {
    super.dispose();
    messageCubit.controller.dispose();
    messageCubit.controller0.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state is ConnectivityConnected) {
          context.read<MessageCubit>().syncPendingMessages(widget.roomId);
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: context.color.chatBackgroundColor,
          appBar: AppBarMessage(context, messageCubit, widget.roomId),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: BlocBuilder<MessageCubit, MessageState>(
                        buildWhen: (previous, current) {
                          return current is MessageLoadingState ||
                              current is MessageErrorState ||
                              current is MessageLoadedState;
                        },
                        builder: (context, state) {
                          if (state is MessageLoadingState) {
                            return const CustomLoading();
                          } else if (state is MessageErrorState) {
                            return Center(
                                child: CustomTextWidget(text: state.errMsg));
                          } else if (state is MessageActionLoadingState) {
                            return const CustomLoading();
                          }
                          if (state is MessageLoadedState) {
                            final messages = state.messages;
                            final pendingImagePath = state.pendingImagePath;
                            return Column(
                              children: [
                                AppBarMessage2(
                                  chatsEntity: widget.chatsEntity,
                                ),
                                Expanded(
                                  child: messages.isEmpty &&
                                          pendingImagePath == null
                                      ? WelcomeMessage(
                                          roomId: widget.roomId,
                                          chatsEntity: widget.chatsEntity,
                                        )
                                      : ListViewBuilderMessages(
                                          messageCubit: messageCubit,
                                          messages: messages,
                                          widget: widget,
                                          focusNode: focusNode,
                                          pendingImagePath: pendingImagePath,
                                          chatsEntity: widget.chatsEntity,
                                        ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: BlocBuilder<MessageCubit, MessageState>(
                        builder: (context, state) {
                          bool isMenuOpen =
                              context.read<MessageCubit>().isMenuOpen;

                          if (isMenuOpen) {
                            return AttachmentMenu(
                              roomId: widget.roomId,
                              friendId: widget.friendId,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SendingMessagesContainer(
                widget: widget,
                focusNode: focusNode,
                chatsEntity: widget.chatsEntity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
