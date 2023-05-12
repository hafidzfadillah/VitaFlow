import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/user/user_food.dart';

class FoodLiteModel extends Serializable {
    final int id;

  final String name;
  final String defaultServing;
  final String defaultSize;
  final num calories;
  final num carbs;
  final num fat;
  final num protein;

  FoodLiteModel({
    required this.id,
    required this.name,
    required this.defaultServing,
    required this.defaultSize,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    
  });

  factory FoodLiteModel.fromJson(Map<String, dynamic> json) => FoodLiteModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        defaultServing: json['default_serving'] ?? "",
        defaultSize: json['default_size'] ?? "",
        calories: json['calories'] ?? 0,
        carbs: json['carbs'] ?? 0,
        fat: json['fat'] ?? 0,
        protein: json['protein'] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "default_serving": defaultServing,
        "default_size": defaultSize,
        "calories": calories,
        "carbs": carbs,
        'fat': fat,
        'protein': protein,

      };
}
