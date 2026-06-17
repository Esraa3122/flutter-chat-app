import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/core/usecases/usecase.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/chats/domain/repositories/chats_repositories.dart';

class GetChatsUseCase implements NoParams{
  final ChatsRepositories chatsRepositories;

  GetChatsUseCase({required this.chatsRepositories});

  Stream<Either<Failure ,List<ChatsEntity>>> call() {
    return chatsRepositories.getChatsList();
  }
}