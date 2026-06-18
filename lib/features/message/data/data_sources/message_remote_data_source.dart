import 'package:e_chat/features/message/data/data_sources/message_local_data_source.dart';
import 'package:e_chat/features/message/data/models/message_model.dart';

abstract class MessageRemoteDataSource {
  Future<void> sendMessage(
      {required MessageModel messageModel, required String roomId});
  Future<void> readMessage({required String roomId, required String msgId});
  Stream<List<MessageModel>> getMessages({required String roomId});
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final MessageLocalDataSource messageLocalDataSource;
  MessageRemoteDataSourceImpl({required this.messageLocalDataSource});
  
  @override
  Stream<List<MessageModel>> getMessages({required String roomId}) {
    return messageLocalDataSource.getMessagesStream(roomId);
  }

  @override
  Future<void> sendMessage(
      {required MessageModel messageModel, required String roomId}) async {
    await messageLocalDataSource.sendMessage(roomId, messageModel);
  }

 @override
  Future<void> readMessage({required String roomId, required String msgId}) async {
    await messageLocalDataSource.readMessage(roomId, msgId);
  }
}