import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'article_model.dart';

class ArticleController extends GetxController {
  final String baseUrl = 'https://flutter.starbuzz.tech/articles';

  var articles = <Article>[].obs;
  var isLoading = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var totalRecords = 0.obs;
  final int pageSize = 10;

  void fetchArticles(
      {int page = 1, String? title, String? category, String? author}) async {
    try {
      isLoading(true);
      final filters = {
        "title": {
          "values": title != null && title.isNotEmpty ? [title] : [""]
        },
        "category": {
          "values": category != null && category.isNotEmpty ? [category] : [""]
        },
        "author": {
          "values": author != null && author.isNotEmpty ? [author] : [""]
        }
      };

      final uri = Uri.parse(
          '$baseUrl?filters=${jsonEncode(filters)}&page=$page&size=$pageSize');
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final records = data["data"]["records"] as List;

        articles.clear(); // Clear old data before updating
        articles.addAll(records.map((json) => Article.fromJson(json)).toList());
        articles.refresh(); // Force GetX to update the UI

        totalRecords.value = data["data"]["total_records"];
        currentPage.value = data["data"]["current_page"];
        lastPage.value = data["data"]["last_page"];
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void addArticle({
    required String title,
    required String author,
    required String category,
    required String description,
    required int readTime,
  }) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "title": title,
          "author": author,
          "category": category,
          "description": description,
          "read_time": readTime,
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Article added successfully!");
        fetchArticles(); // Refresh the list
        Get.back(); // Close the add article page
      } else {
        throw Exception('Failed to add article');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void updateArticle({
    required String articleId,
    String? title,
    String? description,
    int? readTime,
  }) async {
    try {
      isLoading(true);
      Map<String, dynamic> updateData = {};
      if (title != null) updateData["title"] = title;
      if (description != null) updateData["description"] = description;
      if (readTime != null) updateData["read_time"] = readTime;

      final response = await http.patch(
        Uri.parse('$baseUrl/$articleId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updateData),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Article updated successfully!");
        fetchArticles(); // Refresh list
        Get.back(); // Close edit screen
      } else {
        throw Exception('Failed to update article');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void loadMore() {
    if (currentPage.value < lastPage.value) {
      fetchArticles(page: currentPage.value + 1);
    }
  }
}
