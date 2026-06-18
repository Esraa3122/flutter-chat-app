import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:easy_localization/easy_localization.dart';

class ChatsModel extends ChatsEntity {
  ChatsModel({
    required super.id,
    required super.members,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.createdAt,
    super.friendName,
    super.friendImage,
    super.unreadCount,
    super.phone,
    super.countryCode,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) => ChatsModel(
        id: json["id"] ?? "",
        members: json["members"] ?? [],
        lastMessage: json["last_message"] ?? "",
        lastMessageTime: _parseDate(json["last_message_time"]),
        createdAt: _parseDate(json["created_at"]),
        friendName: json["friend_name"] ?? "unknown".tr(),
        friendImage: json["friend_image"] ?? "",
        unreadCount: json["unread_count"] ?? 0,
        phone: json["phone"] ?? "1234567891",
        countryCode: json['country_code'] ?? "+20",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "members": members,
        "last_message": lastMessage,
        "last_message_time": lastMessageTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "friend_name": friendName,
        "friend_image": friendImage,
        "unread_count": unreadCount,
        "phone": phone,
        "country_code": countryCode,
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