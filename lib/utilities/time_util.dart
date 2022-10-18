import 'package:intl/intl.dart';

class TimeUtil {
  static String formatDateTime(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }

  static String getTime(String time) {
    final DateTime now = DateTime.now();
    final String formattedDateTime = formatDateTime(now);
    return formattedDateTime;
  }

  static String getZeroPaddedDigit(int unit) {
    if (unit < 10) {
      return '0$unit';
    } else {
      return '$unit';
    }
  }
}
