import 'package:e_chat/features/chats/data/data_sources/mock_database.dart';
import 'package:e_chat/features/chats/data/models/chats_model.dart';

abstract class ChatsRemoteDataSource {
  Stream<List<ChatsModel>> getChatsList();
}

class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final MockChatLocalDataSource mockChatDataSource;

  ChatsRemoteDataSourceImpl({required this.mockChatDataSource});

  @override
  Stream<List<ChatsModel>> getChatsList() {
    return mockChatDataSource.getChatsStream();
  }
}