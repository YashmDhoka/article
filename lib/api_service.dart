import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_model.dart';

class ApiService {
  final String baseUrl = 'https://flutter.starbuzz.tech/articles';

  Future<Map<String, dynamic>> fetchArticles({
    int page = 1,
    int size = 10,
    String? title,
    String? category,
    String? author,
  }) async {
    final filters = {
      "title": {
        "values": title != null ? [title] : [""]
      },
      "category": {
        "values": category != null ? [category] : [""]
      },
      "author": {
        "values": author != null ? [author] : [""]
      }
    };

    final uri = Uri.parse(
        '$baseUrl?filters=${jsonEncode(filters)}&page=$page&size=$size');

    final response =
        await http.get(uri, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final records = data["data"]["records"] as List;
      return {
        "articles": records.map((json) => Article.fromJson(json)).toList(),
        "totalRecords": data["data"]["total_records"],
        "currentPage": data["data"]["current_page"],
        "lastPage": data["data"]["last_page"]
      };
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
