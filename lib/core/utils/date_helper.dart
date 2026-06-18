import 'package:easy_localization/easy_localization.dart';

class DateHelper {
  static String formatMessageTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('hh:mm a').format(date); 
  }

  static String getChatDayHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate == today) {
      return 'today'.tr();
    } else if (targetDate == yesterday) {
      return 'yesterday'.tr(); 
    } else {
      return DateFormat('dd MMM yyyy').format(date); 
    }
  }

  static String formatDetailedTime(DateTime? date) {
    if (date == null) return '';
    String day = getChatDayHeader(date);
    String time = formatMessageTime(date);
    
    return '$day • $time';
  }

  static String formatChatTime(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final targetDate = DateTime(date.year, date.month, date.day);
    final today = DateTime(now.year, now.month, now.day);

    if (targetDate == today) {
      return DateFormat('hh:mm a').format(date); 
    } else if (targetDate == DateTime(now.year, now.month, now.day - 1)) {
      return 'yesterday'.tr(); 
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }
}