import 'package:intl/intl.dart';

class TimeUtil {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }

  static String getTime(String time) {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDateTime(now);
    return formattedDateTime;
  }
}
