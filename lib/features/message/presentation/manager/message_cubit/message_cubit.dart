import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_chat/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:e_chat/config/app/upload_image/presentation/screens/widgets/image_pick.dart';
import 'package:e_chat/core/mixins/attachment_sender_mixin.dart';
import 'package:e_chat/core/network/netwok_info.dart';
import 'package:e_chat/core/services/contact_service.dart';
import 'package:e_chat/core/services/location_service.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/domain/use_cases/get_message_use_case.dart';
import 'package:e_chat/features/message/domain/use_cases/read_message_use_case.dart';
import 'package:e_chat/features/message/domain/use_cases/send_message_use_case.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> with AttachmentSenderMixin {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final ReadMessageUseCase readMessageUseCase;
  final NetworkInfo networkInfo;
  final TextEditingController controller = TextEditingController();
  final ScrollController controller0 = ScrollController();
  
  @override
  final LocationService locationService;
  @override
  final ContactService contactService;

  StreamSubscription? _messagesSubscription;

  final UploadImageUseCase uploadImageUseCase;

  MessageCubit({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.readMessageUseCase,
    required this.uploadImageUseCase,
    required this.locationService,
    required this.contactService,
    required this.networkInfo,
  }) : super(MessageInitial());

  void getMessages(String roomId) {
    emit(MessageLoadingState());

    _messagesSubscription?.cancel();
    _messagesSubscription = getMessagesUseCase.call(roomId).listen((result) {
      if (!isClosed) {
        result.fold(
          (failure) => emit(MessageErrorState(errMsg: failure.massage)),
          (messages) {
            MessageEntity? currentReply;
            bool currentTyping = false;

            if (state is MessageLoadedState) {
              currentReply = (state as MessageLoadedState).replyMessage;
              currentTyping = (state as MessageLoadedState).isFriendTyping;
            }

            if (messages.isNotEmpty && messages.first.fromId != 'user_me') {
              currentTyping = false;
              
              readMessage(roomId, messages.first.id!); 
            }

            emit(MessageLoadedState(
              messages: messages,
              replyMessage: currentReply,
              isFriendTyping: currentTyping,
            ));
          },
        );
      }
    });
  }

  bool _isMenuOpen = false;
  bool issMenuOpen = false;
  bool get isMenuOpen => _isMenuOpen;

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;

    if (state is MessageLoadedState) {
      emit((state as MessageLoadedState).copyWith());
    }
  }

  void toggleMenuState(bool isOpen) {
    issMenuOpen = isOpen;
    emit(ChatsMenuState(isMenuOpen));
  }

  Future<void> initChat(String roomId, String friendId) async {
    emit(MessageLoadingState());

    getMessages(roomId);
  }

  void selectReplyMessage(MessageEntity message) {
    if (state is MessageLoadedState) {
      emit((state as MessageLoadedState).copyWith(replyMessage: message));
    }
  }

  void cancelReply() {
    if (state is MessageLoadedState) {
      emit((state as MessageLoadedState).copyWith(clearReply: true));
    }
  }

  Future<void> sendMessage(MessageEntity message, String roomId) async {
    if (message.fromId == 'user_me' && state is MessageLoadedState) {
      emit((state as MessageLoadedState).copyWith(isFriendTyping: true));
    }

    final result = await sendMessageUseCase.call(message, roomId);
    
    result.fold(
      (failure) {
        if (!isClosed) emit(MessageActionErrorState(errMsg: failure.massage));
      },
      (_) async {
        bool hasInternet = await networkInfo.isConnected;

        if (hasInternet) {
          await Future.delayed(const Duration(milliseconds: 500));
          await sendMessageUseCase.call(message.copyWith(read: "sent"), roomId);

          await Future.delayed(const Duration(milliseconds: 500));
          await sendMessageUseCase.call(message.copyWith(read: "delivered"), roomId);
          
        }
      },
    );
  }

  Future<void> sendTextMessage({required String roomId, required String friendId}) async {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    MessageEntity? currentReply;
    if (state is MessageLoadedState) {
      currentReply = (state as MessageLoadedState).replyMessage;
    }

    String msgId = DateTime.now().millisecondsSinceEpoch.toString();

    final newMessage = MessageEntity(
      id: msgId,
      message: text,
      createdAt: DateTime.now(),
      fromId: 'user_me', 
      type: "text",
      read: "sending", 
      replyMessage: currentReply,
    );

    controller.clear();
    cancelReply();
    _scrollToBottom();

    await sendMessage(newMessage, roomId);
  }

  Future<void> syncPendingMessages(String roomId) async {
    if (state is MessageLoadedState) {
      final messages = (state as MessageLoadedState).messages;
      
      final pendingMessages = messages.where((m) => m.fromId == 'user_me' && m.read == 'sending').toList();

      for (var msg in pendingMessages) {
        await Future.delayed(const Duration(milliseconds: 400));
        await sendMessageUseCase.call(msg.copyWith(read: "sent"), roomId);
        
        await Future.delayed(const Duration(milliseconds: 400));
        await sendMessageUseCase.call(msg.copyWith(read: "delivered"), roomId);
      }
    }
  }

  Future<void> sendImageMessage(
      {required String roomId,
      required String friendId,
      required ImageSource source}) async {
    MessageEntity? currentReply;
    if (state is MessageLoadedState) {
      currentReply = (state as MessageLoadedState).replyMessage;
    }

    final XFile? pickedFile = await PickImageUtils().pickImage(source);
    if (pickedFile == null) return;

    toggleMenu();

    if (state is MessageLoadedState) {
      emit((state as MessageLoadedState).copyWith(
        clearReply: true,
        pendingImagePath: pickedFile.path,
      ));
    }

    _scrollToBottom();

    final uploadResult = await uploadImageUseCase.call(pickedFile);

    await uploadResult.fold(
      (failure) async {
        if (!isClosed) {
          if (state is MessageLoadedState) {
            emit((state as MessageLoadedState)
                .copyWith(clearPendingImage: true));
          }
          emit(MessageActionErrorState(errMsg: failure.massage));
        }
      },
      (uploadEntity) async {
        final String? imageUrl = uploadEntity.photo;
        if (imageUrl == null || imageUrl.isEmpty) {
          if (!isClosed && state is MessageLoadedState) {
            emit((state as MessageLoadedState)
                .copyWith(clearPendingImage: true));
          }
          return;
        }

        String msgId = DateTime.now().millisecondsSinceEpoch.toString();

        final newImageMessage = MessageEntity(
          id: msgId,
          message: imageUrl,
          createdAt: DateTime.now(),
          fromId: 'user_me',
          type: "image",
          read: "sending",
          replyMessage: currentReply,
        );

        await sendMessage(newImageMessage, roomId);

        if (!isClosed && state is MessageLoadedState) {
          emit((state as MessageLoadedState).copyWith(clearPendingImage: true));
        }
      },
    );
  }

  Future<void> sendLocationMessage(
      {required String chatId, required String friendId}) async {
    final currentState = state;

    MessageEntity? currentReply;
    if (state is MessageLoadedState) {
      currentReply = (state as MessageLoadedState).replyMessage;
    }

    toggleMenu();

    try {
      final locationData = await buildLocationPayload();

      if (locationData != null) {
        String msgId = DateTime.now().millisecondsSinceEpoch.toString();

        final newMessage = MessageEntity(
          id: msgId,
          message: locationData,
          createdAt: DateTime.now(),
          fromId: 'user_me',
          type: "location",
          read: "sending",
          replyMessage: currentReply,
        );

        cancelReply();
        _scrollToBottom();

        await sendMessage(newMessage, chatId);
      } else {
        emit(MessageActionErrorState(
            errMsg: "access_to_the_site_has_been_denied".tr()));
        if (currentState is MessageLoadedState) emit(currentState);
      }
    } catch (e) {
      emit(MessageActionErrorState(errMsg: e.toString()));
      if (currentState is MessageLoadedState) emit(currentState);
    }
  }

  Future<void> sendContactMessage(
      {required String chatId, required String friendId}) async {
    final currentState = state;
    MessageEntity? currentReply;

    if (state is MessageLoadedState) {
      currentReply = (state as MessageLoadedState).replyMessage;
    }

    toggleMenu();

    try {
      final contactData = await buildContactPayload();

      if (contactData != null) {
        String msgId = DateTime.now().millisecondsSinceEpoch.toString();

        final newMessage = MessageEntity(
          id: msgId,
          message: contactData,
          createdAt: DateTime.now(),
          fromId: 'user_me',
          type: "contact",
          read: "sending",
          replyMessage: currentReply,
        );

        cancelReply();
        _scrollToBottom();
        
        await sendMessage(newMessage, chatId);
      } else {
        emit(MessageActionErrorState(errMsg: "no_contact_selected".tr()));
        if (currentState is MessageLoadedState) emit(currentState);
      }
    } catch (e) {
      emit(MessageActionErrorState(errMsg: e.toString()));
      if (currentState is MessageLoadedState) emit(currentState);
    }
  }

  void _scrollToBottom() {
    if (controller0.hasClients) {
      controller0.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> readMessage(String roomId, String msgId) async {
    await readMessageUseCase.call(roomId, msgId);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}