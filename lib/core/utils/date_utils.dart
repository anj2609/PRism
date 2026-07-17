import 'package:timeago/timeago.dart' as timeago;

class AppDateUtils {
  AppDateUtils._();

  static String timeAgo(DateTime date) {
    return timeago.format(date);
  }

  static String formatFull(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}
