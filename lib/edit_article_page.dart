import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'article_controller.dart';
import 'article_model.dart';

class EditArticlePage extends StatelessWidget {
  final ArticleController controller = Get.find<ArticleController>();
  final Article article;

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController readTimeController;

  EditArticlePage({super.key, required this.article})
      : titleController = TextEditingController(text: article.title),
        descriptionController =
            TextEditingController(text: article.description),
        readTimeController =
            TextEditingController(text: article.readTime.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Article")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: readTimeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Read Time (mins)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.updateArticle(
                  articleId: article.id,
                  title: titleController.text,
                  description: descriptionController.text,
                  readTime: int.tryParse(readTimeController.text),
                );
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
