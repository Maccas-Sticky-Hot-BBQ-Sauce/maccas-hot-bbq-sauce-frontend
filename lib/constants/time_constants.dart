import 'package:flutter_dotenv/flutter_dotenv.dart';

class TimeConstants {
  static int daySubtract = int.parse(
      const String.fromEnvironment("DAY_SUBTRACT").isNotEmpty
          ? const String.fromEnvironment("DAY_SUBTRACT")
          : dotenv.get('DAY_SUBTRACT', fallback: '0'));
}
