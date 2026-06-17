import 'package:easy_localization/easy_localization.dart';

class DateHelper {
  
  static String formatMessageTime(DateTime? dateTime) {
    if (dateTime == null) return "";
    return DateFormat('hh:mm a').format(dateTime);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool _isYesterday(DateTime date, DateTime now) {
    final yesterday = now.subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  static String getChatDayHeader(DateTime messageDate) {
    final now = DateTime.now();

    if (isSameDay(messageDate, now)) {
      return "today".tr();
    } else if (_isYesterday(messageDate, now)) {
      return "yesterday".tr();
    } else {
      return '${messageDate.day}/${messageDate.month}/${messageDate.year}';
    }
  }

  static String formatChatTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    String timeOnly = DateFormat('hh:mm a').format(dateTime);

    if (isSameDay(dateTime, now)) {
      return "${"today".tr()} • $timeOnly";
    } else if (_isYesterday(dateTime, now)) {
      return "${"yesterday".tr()} • $timeOnly";
    } else {
      return DateFormat('dd MMM • hh:mm a').format(dateTime);
    }
  }

  static String formatGroupTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';

    DateTime dateTime;
    int? millis = int.tryParse(dateString);
    
    if (millis != null) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
    } else {
      dateTime = DateTime.tryParse(dateString) ?? DateTime.now();
    }

    return formatChatTime(dateTime); 
  }

  static String getShortLocation(String? fullAddress) {
    if (fullAddress == null || fullAddress.isEmpty) {
      return "";
    }
    
    List<String> parts = fullAddress.split(',');
    
    if (parts.length >= 2) {
      String country = parts.last.trim();
      String city = parts[parts.length - 2].trim();
      
      return "$city, $country"; 
    }
    
    return fullAddress;
  }  
}