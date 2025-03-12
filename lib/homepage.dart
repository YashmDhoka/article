import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'article_controller.dart';
import 'add_article_page.dart';
import 'article_detail_page.dart';
import 'edit_article_page.dart';

class HomePage extends StatelessWidget {
  final ArticleController controller = Get.put(ArticleController());
  final TextEditingController searchController = TextEditingController();
  final RxString selectedCategory = "".obs;
  final RxString selectedAuthor = "".obs;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Articles")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => DropdownButton<String>(
                          isExpanded: true,
                          value: selectedCategory.value.isEmpty
                              ? null
                              : selectedCategory.value,
                          hint: const Text("Category"),
                          items: ["Programming", "Technology"]
                              .map((category) => DropdownMenuItem(
                                  value: category, child: Text(category)))
                              .toList(),
                          onChanged: (value) {
                            selectedCategory.value = value ?? "";
                          },
                        )),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Obx(
                      () => DropdownButton<String>(
                        isExpanded: true,
                        value: selectedAuthor.value.isEmpty
                            ? null
                            : selectedAuthor.value,
                        hint: const Text("Author"),
                        items: ["Jane Smith", "John Doe"]
                            .map((author) => DropdownMenuItem(
                                value: author, child: Text(author)))
                            .toList(),
                        onChanged: (value) {
                          selectedAuthor.value = value ?? "";
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 18,
                    ),
                    onPressed: () {
                      controller.fetchArticles(
                        title: searchController.text.trim(),
                        category: selectedCategory.value.trim().isEmpty
                            ? null
                            : selectedCategory.value,
                        author: selectedAuthor.value.trim().isEmpty
                            ? null
                            : selectedAuthor.value,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.clear,
                      size: 18,
                    ),
                    onPressed: () {
                      searchController.clear();
                      selectedCategory.value = "";
                      selectedAuthor.value = "";
                      controller
                          .fetchArticles(); // Reset filters and reload articles
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.articles.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.articles.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.articles.length) {
                    return controller.currentPage.value <
                            controller.lastPage.value
                        ? Center(
                            child: ElevatedButton(
                              onPressed: controller.loadMore,
                              child: const Text("Load More"),
                            ),
                          )
                        : const SizedBox();
                  }

                  final article = controller.articles[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () =>
                          Get.to(() => ArticleDetailsPage(article: article)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        tileColor: const Color.fromARGB(255, 132, 93, 238),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            article.title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(article.description),
                              Text("By: ${article.author}"),
                              Text("Category: ${article.category}"),
                              Text("Read Time: ${article.readTime} mins"),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 18,
                          ),
                          onPressed: () =>
                              Get.to(() => EditArticlePage(article: article)),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddArticlePage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
