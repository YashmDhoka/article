import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'article_controller.dart';

class AddArticlePage extends StatelessWidget {
  final ArticleController controller = Get.find<ArticleController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController readTimeController = TextEditingController();

  AddArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Article")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: "Author"),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
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
                controller.addArticle(
                  title: titleController.text,
                  author: authorController.text,
                  category: categoryController.text,
                  description: descriptionController.text,
                  readTime: int.tryParse(readTimeController.text) ?? 0,
                );
                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
