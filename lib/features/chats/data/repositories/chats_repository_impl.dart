import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/core/network/netwok_info.dart';
import 'package:e_chat/features/chats/data/data_sources/chats_remote_data_source.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/chats/domain/repositories/chats_repositories.dart';

class ChatsRepositoryImpl implements ChatsRepositories {
  final NetworkInfo networkInfo;
  final ChatsRemoteDataSource chatsRemoteDataSource;

  ChatsRepositoryImpl(
      {required this.networkInfo, required this.chatsRemoteDataSource});

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
}