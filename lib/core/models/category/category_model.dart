import 'package:vitaflow/core/models/api/api_result_model.dart';

class CategoryModel extends Serializable {
  final int id;
  final String name;
  CategoryModel({
    required this.id,
    required this.name,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "");

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
