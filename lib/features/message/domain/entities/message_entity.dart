class MessageEntity {
  String? message;
  String? id;
  DateTime? createdAt;
  String? toId;
  String? fromId;
  String? type;
  String? read;
  MessageEntity? replyMessage;
  String? sharedPostId;

  MessageEntity({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.fromId,
    required this.type,
    required this.read,
    required this.replyMessage,
    this.sharedPostId,
  });

  MessageEntity copyWith({String? message, String? read}) {
    return MessageEntity(
      id: id,
      message: message ?? this.message,
      createdAt: createdAt,
      fromId: fromId,
      type: type,
      read: read ?? this.read, 
      replyMessage: replyMessage,
      sharedPostId: sharedPostId,
    );
  }

}
