import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/domain/repositories/message_repo.dart';

class GetMessagesUseCase{
  final MessageRepository messageRepository;
  GetMessagesUseCase({required this.messageRepository});

  Stream<Either<Failure, List<MessageEntity>>> call(String roomId) {
    return messageRepository.getMessages(roomId: roomId);
  }
}