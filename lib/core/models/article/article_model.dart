import 'package:vitaflow/core/models/api/api_result_model.dart';

class ArticleModel extends Serializable {
  final int id;
  final String name;
  final String image;
  final String content;
  final int categoryId;
  final String category;
  final int readingTime;

  ArticleModel({
    required this.id,
    required this.name,
    required this.image,
    required this.content,
    required this.categoryId,
    required this.category,
    required this.readingTime,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        image: json['image'] ?? "",
        content: json['content'] ?? "",
        categoryId: json['category_id'] ?? 0,
        category: json['category'] ?? "",
        readingTime: json['reading_time'] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "content": content,
        "category_id": categoryId,
        "category": category,
        "reading_time": readingTime,
      };
}
