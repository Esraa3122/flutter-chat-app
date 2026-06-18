import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/core/usecases/usecase.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/chats/domain/repositories/chats_repositories.dart';

class SearchChatsUseCase implements UseCase<List<ChatsEntity>, String> {
  final ChatsRepositories chatsRepositories;

  SearchChatsUseCase({required this.chatsRepositories});

  @override
  Future<Either<Failure, List<ChatsEntity>>> call(String query) async {
    return await chatsRepositories.searchChats(query);
  }
}