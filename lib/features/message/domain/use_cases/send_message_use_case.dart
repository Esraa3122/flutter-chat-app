import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/features/message/domain/entities/message_entity.dart';
import 'package:e_chat/features/message/domain/repositories/message_repo.dart';

class SendMessageUseCase {
  final MessageRepository messageRepository;

  SendMessageUseCase({required this.messageRepository});

  Future<Either<Failure, void>> call(
      MessageEntity message, String roomId) async {
    return await messageRepository.sendMessage(
        message: message, roomId: roomId);
  }
}
