import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';

abstract class ChatsRepositories {
  Stream<Either<Failure , List<ChatsEntity>>> getChatsList();
  Future<Either<Failure, List<ChatsEntity>>> searchChats(String query);
}
