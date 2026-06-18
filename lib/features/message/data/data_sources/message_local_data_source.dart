import 'dart:async';
import 'dart:convert';
import 'package:e_chat/core/helpers/hive_helper.dart';
import 'package:e_chat/features/chats/data/data_sources/chat_local_data_source.dart';
import 'package:e_chat/features/message/data/models/message_model.dart';

abstract class MessageLocalDataSource {
  Stream<List<MessageModel>> getMessagesStream(String roomId);
  Future<void> sendMessage(String roomId, MessageModel msg);
  Future<void> readMessage(String roomId, String msgId);
}

class MessageLocalDataSourceImpl implements MessageLocalDataSource {
  final HiveHelper hiveHelper;
  final ChatLocalDataSource chatsLocalDataSource;
  final String myUserId = 'user_me';

  MessageLocalDataSourceImpl({
    required this.hiveHelper,
    required this.chatsLocalDataSource,
  });

  final Map<String, StreamController<List<MessageModel>>> _messageControllers =
      {};

  @override
  Stream<List<MessageModel>> getMessagesStream(String roomId) async* {
    final savedData = hiveHelper.getData(key: roomId);
    List<MessageModel> messages = [];

    if (savedData != null && savedData is String) {
      final List decoded = jsonDecode(savedData);
      messages = decoded.map((e) => MessageModel.fromJson(e)).toList();
    } 
    else {
      if (roomId == 'room_4') {
        messages = [];
      } else{
      String initialMsg = 'Hello Eman!';
      if (roomId == 'room_2') initialMsg = 'Are we meeting today?';
      if (roomId == 'room_3') initialMsg = 'Send me the photo please.';

      messages = [
        MessageModel(
          id: 'msg_initial_$roomId',
          message: initialMsg,
          createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
          fromId: roomId.replaceAll('room_', 'user_friend_'),
          type: 'text',
          read: 'sent',
          replyMessage: null,
        )
      ];
      }
    }

    bool needsUpdate = false;
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].fromId != myUserId && messages[i].read != 'read') {
        final oldMsg = messages[i];
        messages[i] = MessageModel(
          id: oldMsg.id,
          message: oldMsg.message,
          createdAt: oldMsg.createdAt,
          fromId: oldMsg.fromId,
          type: oldMsg.type,
          read: 'read',
          replyMessage: oldMsg.replyMessage,
        );
        needsUpdate = true;
      }
    }

    if (needsUpdate) {
      await hiveHelper.saveData(
          key: roomId,
          value: jsonEncode(messages.map((e) => e.toJson()).toList()));
    }

    await chatsLocalDataSource.resetUnreadCount(roomId);

    yield messages;

    if (!_messageControllers.containsKey(roomId)) {
      _messageControllers[roomId] =
          StreamController<List<MessageModel>>.broadcast();
    }
    yield* _messageControllers[roomId]!.stream;
  }

  @override
  @override
  Future<void> sendMessage(String roomId, MessageModel msg) async {
    final savedData = hiveHelper.getData(key: roomId);
    List<MessageModel> currentMessages = [];
    if (savedData != null && savedData is String) {
      currentMessages = (jsonDecode(savedData) as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();
    }

    int index = currentMessages.indexWhere((m) => m.id == msg.id);
    bool isNewMessage = index == -1;

    bool justReachedServer = false;
    if (!isNewMessage) {
      if (currentMessages[index].read == 'sending' && msg.read == 'sent') {
        justReachedServer = true;
      }
    }

    if (isNewMessage) {
      currentMessages.insert(0, msg);
    } else {
      currentMessages[index] = msg;
    }

    await hiveHelper.saveData(
        key: roomId,
        value: jsonEncode(currentMessages.map((e) => e.toJson()).toList()));
    _messageControllers[roomId]?.add(currentMessages);
    await chatsLocalDataSource.updateChatLastMessage(roomId, msg);

    if (justReachedServer && msg.fromId == myUserId) {
      Future.delayed(const Duration(seconds: 2), () async {
        final latestSavedData = hiveHelper.getData(key: roomId);
        List<MessageModel> latestMessages = [];
        if (latestSavedData != null && latestSavedData is String) {
          latestMessages = (jsonDecode(latestSavedData) as List)
              .map((e) => MessageModel.fromJson(e))
              .toList();
        }

        int msgIndex = latestMessages.indexWhere((m) => m.id == msg.id);
        if (msgIndex != -1) {
          final oldMsg = latestMessages[msgIndex];
          latestMessages[msgIndex] = MessageModel(
            id: oldMsg.id,
            message: oldMsg.message,
            createdAt: oldMsg.createdAt,
            fromId: oldMsg.fromId,
            type: oldMsg.type,
            read: 'read',
            replyMessage: oldMsg.replyMessage,
          );
        }

        final replyMsg = MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: msg.type == 'image'
              ? 'Nice photo!'
              : msg.type == 'location'
                  ? 'Thanks'
                  : msg.type == 'contact'
                      ? 'Thanks'
                      : 'Me To: ${msg.message}',
          createdAt: DateTime.now(),
          fromId: roomId.replaceAll('room_', 'user_friend_'),
          type: 'text',
          read: 'sent',
          replyMessage: null,
        );

        latestMessages.insert(0, replyMsg);
        await hiveHelper.saveData(
            key: roomId,
            value: jsonEncode(latestMessages.map((e) => e.toJson()).toList()));
        _messageControllers[roomId]?.add(latestMessages);
        await chatsLocalDataSource.updateChatLastMessage(roomId, replyMsg);
      });
    }
  }

  @override
  Future<void> readMessage(String roomId, String msgId) async {
    await chatsLocalDataSource.resetUnreadCount(roomId);

    final savedData = hiveHelper.getData(key: roomId);
    if (savedData != null && savedData is String) {
      List<MessageModel> currentMessages = (jsonDecode(savedData) as List)
          .map((e) => MessageModel.fromJson(e))
          .toList();

      int index = currentMessages.indexWhere((m) => m.id == msgId);

      if (index != -1 && currentMessages[index].read != 'read') {
        final oldMsg = currentMessages[index];
        currentMessages[index] = MessageModel(
          id: oldMsg.id,
          message: oldMsg.message,
          createdAt: oldMsg.createdAt,
          fromId: oldMsg.fromId,
          type: oldMsg.type,
          read: 'read',
          replyMessage: oldMsg.replyMessage,
        );

        await hiveHelper.saveData(
            key: roomId,
            value: jsonEncode(currentMessages.map((e) => e.toJson()).toList()));
        _messageControllers[roomId]?.add(currentMessages);
      }
    }
  }
}
