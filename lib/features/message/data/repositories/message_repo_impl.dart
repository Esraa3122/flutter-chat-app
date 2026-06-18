import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/core/network/netwok_info.dart';
import 'package:e_chat/features/message/data/data_sources/message_remote_data_source.dart';
import 'package:e_chat/features/message/data/models/message_model.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/domain/repositories/message_repo.dart';

class MessageRepoImpl implements MessageRepository {
  final NetworkInfo networkInfo;
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepoImpl(
      {required this.networkInfo, required this.messageRemoteDataSource});

  @override
  Future<Either<Failure, void>> sendMessage(
      {required MessageEntity message, required String roomId}) async {
    try {
      final messageModel = MessageModel(
        id: message.id,
        message: message.message,
        createdAt: message.createdAt,
        fromId: message.fromId,
        type: message.type,
        read: message.read, replyMessage: message.replyMessage,
      );
      await messageRemoteDataSource.sendMessage(
          messageModel: messageModel, roomId: roomId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> readMessage(
      {required String roomId, required String msgId}) async {
    try {
      await messageRemoteDataSource.readMessage(roomId: roomId, msgId: msgId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
      {required String roomId}) async* {
    try {
      await for (var messages
          in messageRemoteDataSource.getMessages(roomId: roomId)) {
        yield Right(messages);
      }
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }
}
