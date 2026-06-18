import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/core/network/netwok_info.dart';
import 'package:e_chat/features/chats/data/data_sources/chat_local_data_source.dart';
import 'package:e_chat/features/chats/data/data_sources/chats_remote_data_source.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/chats/domain/repositories/chats_repositories.dart';

class ChatsRepositoryImpl implements ChatsRepositories {
  final NetworkInfo networkInfo;
  final ChatsRemoteDataSource chatsRemoteDataSource;
  final ChatLocalDataSource chatLocalDataSource;

  ChatsRepositoryImpl(
      {required this.networkInfo, required this.chatsRemoteDataSource, required this.chatLocalDataSource});

  @override
  Stream<Either<Failure, List<ChatsEntity>>> getChatsList() async* {
    try {
      await for (var modelsList in chatsRemoteDataSource.getChatsList()) {
        yield Right(modelsList);
      }
    } catch (error) {
      yield Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatsEntity>>> searchChats(String query) async {
    try {
      final result = await chatLocalDataSource.searchChats(query);
      return Right(result);
    } catch (e) {
      return Left(
          ServerFailure(e.toString())); 
    }
  }
}
