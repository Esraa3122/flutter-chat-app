import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/features/message/domain/repositories/message_repo.dart';

class ReadMessageUseCase {
  final MessageRepository messageRepository;
  ReadMessageUseCase({required this.messageRepository});

  Future<Either<Failure, void>> call(String roomId, String msgId) async {
    return await messageRepository.readMessage(roomId: roomId, msgId: msgId);
  }
}