part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

final class MessageLoadingState extends MessageState {}
final class MessageLoadedState extends MessageState {
  final List<MessageEntity> messages;
  final MessageEntity? replyMessage;
  final String? pendingImagePath;
  final bool isFriendTyping;
  MessageLoadedState({
    required this.messages,
    this.replyMessage,
    this.pendingImagePath, this.isFriendTyping = false,
  });

  MessageLoadedState copyWith({
    List<MessageEntity>? messages,
    MessageEntity? replyMessage,
    bool clearReply = false,
    String? pendingImagePath,
    bool clearPendingImage = false,
    bool? isFriendTyping,
  }) {
    return MessageLoadedState(
      messages: messages ?? this.messages,
      replyMessage: clearReply ? null : (replyMessage ?? this.replyMessage),
      pendingImagePath: clearPendingImage
          ? null
          : (pendingImagePath ?? this.pendingImagePath), isFriendTyping: isFriendTyping ?? this.isFriendTyping,
    );
  }
}
final class MessageErrorState extends MessageState {
  final String errMsg;
  MessageErrorState({required this.errMsg});
}

class ChatsMenuState extends MessageState {
  final bool isMenuOpen;
  ChatsMenuState(this.isMenuOpen);
}


final class MessageActionLoadingState extends MessageState {}
final class MessageActionSuccessState extends MessageState {}
final class MessageActionErrorState extends MessageState {
  final String errMsg;
  MessageActionErrorState({required this.errMsg});
}