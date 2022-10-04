import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static bool isSample = dotenv.env['IS_SAMPLE'] != null &&
          dotenv.env['IS_SAMPLE']!.toLowerCase() != "false"
      ? true
      : false;
  static String baseUrl =
      dotenv.get('BACKEND_API_URL') + (isSample ? '/sample' : '');
  static String stopsEndpoint = '/stop';
}
