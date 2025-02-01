import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../../constants/assets/api_endpoints.dart';

class NewsApiServices {
  var Client = http.Client();
  String newsApiEndpoint = ApiEndpoints.newsApi;
  String NewsApiKey = '${dotenv.env['NEWS_API_KEY']}';

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json"
  };

  Future<http.Response> getEverything(String keyword, int page) {
    debugPrint('$newsApiEndpoint/everything?q=$keyword&language=en&sortBy=publishedAt&page=$page&apiKey=$NewsApiKey');
    return Client.get(
      Uri.parse(
          '$newsApiEndpoint/everything?q=$keyword&language=en&sortBy=publishedAt&page=$page&apiKey=$NewsApiKey'),
      headers: headers,
    );
    
  }
}
