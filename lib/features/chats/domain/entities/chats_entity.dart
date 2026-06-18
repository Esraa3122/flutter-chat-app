class ChatsEntity {
  final String? id;
  final List? members;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final DateTime? createdAt;
  final String? friendName;
  final String? friendImage;
  final int? unreadCount;
  final String? phone;
  final String? countryCode;

  ChatsEntity(
      {this.id,
      this.members,
      this.lastMessage,
      this.lastMessageTime,
      this.createdAt,
      this.friendName,
      this.friendImage,
      this.unreadCount,
      this.phone,
      this.countryCode});
}
