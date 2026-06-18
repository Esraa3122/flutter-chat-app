import 'dart:async';
import 'dart:convert';
import 'package:e_chat/core/helpers/hive_helper.dart';
import 'package:e_chat/features/chats/data/models/chats_model.dart';
import 'package:e_chat/features/message/data/models/message_model.dart';

abstract class ChatLocalDataSource {
  Stream<List<ChatsModel>> getChatsStream();
  Future<void> updateChatLastMessage(String roomId, MessageModel msg);
  Future<void> resetUnreadCount(String roomId);
  Future<List<ChatsModel>> searchChats(String query);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final HiveHelper hiveHelper;
  final String myUserId = 'user_me';

  ChatLocalDataSourceImpl({required this.hiveHelper});

  final StreamController<List<ChatsModel>> _chatsController =
      StreamController<List<ChatsModel>>.broadcast();

  List<ChatsModel> _getSavedChats() {
    final savedChats = hiveHelper.getData(key: 'all_chats');
    if (savedChats != null && savedChats is String) {
      final List decoded = jsonDecode(savedChats);
      return decoded.map((e) => ChatsModel.fromJson(e)).toList();
    }

    return [
      ChatsModel(
          id: 'room_1',
          members: [myUserId, 'user_friend_1'],
          lastMessage: 'Hello Eman!',
          lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          friendName: 'Eman',
          friendImage:
              'https://i.pinimg.com/474x/36/62/27/36622753a0080a44c99f612d3267363e.jpg',
          unreadCount: 0,
          phone: "1005677899",
          countryCode: '+20'),
      ChatsModel(
          id: 'room_2',
          members: [myUserId, 'user_friend_2'],
          lastMessage: 'Are we meeting today?',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          friendName: 'Sara',
          friendImage:
              'https://i.pinimg.com/736x/d1/9a/54/d19a541df3a90920b7674edbb45203fe.jpg',
          unreadCount: 0,
          phone: '1123432345',
          countryCode: '+20'),
      ChatsModel(
          id: 'room_3',
          members: [myUserId, 'user_friend_3'],
          lastMessage: 'Send me the photo please.',
          lastMessageTime: DateTime.now().subtract(const Duration(hours: 1)),
          createdAt: DateTime.now().subtract(const Duration(days: 8)),
          friendName: 'Reham',
          friendImage:
              'https://i.pinimg.com/736x/fc/49/1a/fc491a087bc3aa2a36cf6b713715fb1c.jpg',
          unreadCount: 0,
          phone: '1234325643',
          countryCode: '+20'),
      ChatsModel(
          id: 'room_4',
          members: [myUserId, 'user_friend_4'],
          lastMessage: null,
          lastMessageTime: DateTime.now(),
          createdAt: DateTime.now(),
          friendName: 'Nada',
          friendImage:
              'https://i.pinimg.com/736x/fc/49/1a/fc491a087bc3aa2a36cf6b713715fb1c.jpg',
          unreadCount: 0,
          phone: '1234325643',
          countryCode: '+20'),
    ];
  }

  @override
  Stream<List<ChatsModel>> getChatsStream() async* {
    List<ChatsModel> chats = _getSavedChats();
    yield chats;
    yield* _chatsController.stream;
  }

  @override
  Future<void> updateChatLastMessage(String roomId, MessageModel msg) async {
    List<ChatsModel> chats = _getSavedChats();
    final index = chats.indexWhere((chat) => chat.id == roomId);

    if (index != -1) {
      final oldChat = chats[index];
      chats[index] = ChatsModel(
          id: oldChat.id,
          members: oldChat.members,
          lastMessage: msg.type == 'image'
              ? '📷 Image'
              : msg.type == 'location'
                  ? '📍 location'
                  : msg.type == 'contact'
                      ? '👤 contact'
                      : msg.message,
          lastMessageTime: msg.createdAt,
          createdAt: oldChat.createdAt,
          friendName: oldChat.friendName,
          friendImage: oldChat.friendImage,
          unreadCount:
              msg.fromId != myUserId ? ((oldChat.unreadCount ?? 0) + 1) : 0,
          phone: oldChat.phone,
          countryCode: oldChat.countryCode);

      chats.sort((a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime!));

      final jsonList = chats.map((e) => e.toJson()).toList();
      await hiveHelper.saveData(key: 'all_chats', value: jsonEncode(jsonList));
      _chatsController.add(chats);
    }
  }

  @override
  Future<void> resetUnreadCount(String roomId) async {
    List<ChatsModel> chats = _getSavedChats();
    final index = chats.indexWhere((chat) => chat.id == roomId);

    if (index != -1) {
      final oldChat = chats[index];
      chats[index] = ChatsModel(
          id: oldChat.id,
          members: oldChat.members,
          lastMessage: oldChat.lastMessage,
          lastMessageTime: oldChat.lastMessageTime,
          createdAt: oldChat.createdAt,
          friendName: oldChat.friendName,
          friendImage: oldChat.friendImage,
          unreadCount: 0,
          phone: oldChat.phone,
          countryCode: oldChat.countryCode);

      final jsonList = chats.map((e) => e.toJson()).toList();
      await hiveHelper.saveData(key: 'all_chats', value: jsonEncode(jsonList));
      _chatsController.add(chats);
    }
  }

  @override
  Future<List<ChatsModel>> searchChats(String query) async {
    List<ChatsModel> allChats = _getSavedChats();

    if (query.isEmpty) {
      return allChats;
    }
    return allChats.where((chat) {
      final nameMatch =
          chat.friendName?.toLowerCase().contains(query.toLowerCase()) ?? false;
      final messageMatch =
          chat.lastMessage?.toLowerCase().contains(query.toLowerCase()) ??
              false;
      return nameMatch || messageMatch;
    }).toList();
  }
}
