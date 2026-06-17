part of 'get_chats_cubit.dart';

@immutable
sealed class GetChatsState {}

final class GetChatsInitial extends GetChatsState {}

final class GetChatsLoading extends GetChatsState {}

final class GetChatsSuccess extends GetChatsState {
  final List<ChatsEntity> chatsList;

  GetChatsSuccess({required this.chatsList});
}

final class GetChatsError extends GetChatsState {
  final String errMsg;

  GetChatsError({required this.errMsg});
}
