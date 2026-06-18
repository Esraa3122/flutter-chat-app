import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';


abstract class MessageRepository {
  Future<Either<Failure, void>> sendMessage(
      {required MessageEntity message, required String roomId});
  Future<Either<Failure, void>> readMessage(
      {required String roomId, required String msgId});
  Stream<Either<Failure, List<MessageEntity>>> getMessages(
      {required String roomId});
}
