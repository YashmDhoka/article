class Article {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final int readTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  Article({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.readTime,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      category: json['category'],
      description: json['description'],
      readTime: json['read_time'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'description': description,
      'read_time': readTime,
    };
  }
}
