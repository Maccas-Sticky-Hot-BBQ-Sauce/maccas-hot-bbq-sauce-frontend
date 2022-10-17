import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static bool isSample =
      (const String.fromEnvironment('IS_SAMPLE').isNotEmpty &&
                  const String.fromEnvironment("IS_SAMPLE").toLowerCase() !=
                      "false") ||
              (dotenv.env['IS_SAMPLE'] != null &&
                  dotenv.env['IS_SAMPLE']!.toLowerCase() != "false")
          ? true
          : false;
  static String baseUrl =
      (const String.fromEnvironment("BACKEND_API_URL").isNotEmpty
              ? const String.fromEnvironment("BACKEND_API_URL")
              : dotenv.get('BACKEND_API_URL')) +
          (isSample ? '/sample' : '');
  static String stopsEndpoint = '/stop';
  static String tripsEndpoint = '/trip';
  static String landmarksEndpoint = '/landmark';
  static String currentStopId =
      const String.fromEnvironment("STOP_ID").isNotEmpty
          ? const String.fromEnvironment("STOP_ID")
          : dotenv.get('STOP_ID', fallback: '4975');
}
