import 'package:vitaflow/core/models/api/api_result_model.dart';

class ProductModel extends Serializable {
  final int id;
  final String name;
  final String image;
  final String description;
  final String price;
  final String category;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        image: json['image'] ?? "",
        description: json['description'] ?? "",
        price: json['price'] ?? "",
        category: json['category'] ?? "",
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "category": category,
      };
}
