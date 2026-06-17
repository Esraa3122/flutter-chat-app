import 'dart:async';
import 'dart:convert';
import 'package:e_chat/core/helpers/hive_helper.dart';
import 'package:e_chat/features/chats/data/models/chats_model.dart';

abstract class MockChatLocalDataSource {
  Stream<List<ChatsModel>> getChatsStream();
}

class MockChatLocalDataSourceImpl implements MockChatLocalDataSource {
  final HiveHelper hiveHelper;
  final String myUserId = 'user_me';

  MockChatLocalDataSourceImpl({required this.hiveHelper});

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
        friendImage: 'https://i.pinimg.com/474x/36/62/27/36622753a0080a44c99f612d3267363e.jpg',
        unreadCount: 0,
      ),
      ChatsModel(
        id: 'room_2',
        members: [myUserId, 'user_friend_2'],
        lastMessage: 'Are we meeting today?',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        friendName: 'Sara',
        friendImage: 'https://i.pinimg.com/736x/d1/9a/54/d19a541df3a90920b7674edbb45203fe.jpg',
        unreadCount: 2,
      ),
      ChatsModel(
        id: 'room_3',
        members: [myUserId, 'user_friend_3'],
        lastMessage: 'Send me the files please.',
        lastMessageTime: DateTime.now().subtract(const Duration(days: 1)),
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        friendName: 'Reham',
        friendImage: 'https://i.pinimg.com/736x/fc/49/1a/fc491a087bc3aa2a36cf6b713715fb1c.jpg',
        unreadCount: 0,
      ),
    ];
  }

  @override
  Stream<List<ChatsModel>> getChatsStream() async* {
    List<ChatsModel> chats = _getSavedChats();
    yield chats;
    yield* _chatsController.stream;
  }
}