import 'package:e_chat/features/message/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.message,
    required super.id,
    required super.createdAt,
    required super.fromId,
    required super.type,
    required super.read,
    required super.replyMessage,
    super.sharedPostId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        id: json['id'],
        createdAt: _parseDate(json['created_at']),
        fromId: json['from_id'],
        type: json['type'] ?? 'text',
        read: json['read'],
        sharedPostId: json['shared_post_id'],
        replyMessage: json['reply_message'] != null
            ? MessageModel.fromJson(json['reply_message'] as Map<String, dynamic>)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "created_at": createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
        "from_id": fromId,
        "type": type,
        "id": id,
        "read": read,
        "shared_post_id": sharedPostId,
        "reply_message": replyMessage != null
            ? {
                "id": replyMessage!.id,
                "message": replyMessage!.message,
                "created_at": replyMessage!.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
                "from_id": replyMessage!.fromId,
                "type": replyMessage!.type,
                "read": replyMessage!.read,
              }
            : null
      };

  static DateTime _parseDate(dynamic dateData) {
    if (dateData == null) return DateTime.now();
    if (dateData is String) return DateTime.tryParse(dateData) ?? DateTime.now();
    if (dateData.runtimeType.toString() == 'Timestamp') {
      return (dateData as dynamic).toDate();
    }
    if (dateData is DateTime) return dateData;
    return DateTime.now();
  }
}