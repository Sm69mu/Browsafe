import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static const String faviconURL = 'http://www.google.com/s2/favicons?domain=';
    String newsApi = '${dotenv.env['NEW_API_URL']}';

}