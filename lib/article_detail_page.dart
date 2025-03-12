import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starbuzz/edit_article_page.dart';
import 'article_model.dart';

class ArticleDetailsPage extends StatelessWidget {
  final Article article;

  const ArticleDetailsPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(article.category,
                            style: const TextStyle(color: Colors.white)),
                        backgroundColor: Colors.purple,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text("${article.readTime} min read",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "By ${article.author}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87),
                  ),
                  const Divider(height: 20, thickness: 1),
                  Text(
                    article.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          Get.to(() => EditArticlePage(article: article)),
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Edit Article",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
