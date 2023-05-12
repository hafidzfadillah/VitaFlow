import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/user/user_food.dart';

class FoodModel extends Serializable {
  final int id;

   final String foodName;
  final String foodImage;
  final String foodRating;
  final String servingUnitName;
  final String servingSize;
  final int calories;
  final int fat;
  final int saturatedFat;
  final int transFat;
  final int cholesterol;
  final int sodium;
  final int carbohydrate;
  final int fiber;
  final int sugar;
  final int protein;

  FoodModel({
    required this.id,
     required this.foodName,
    required this.foodImage,
    required this.foodRating,
    required this.servingUnitName,
    required this.servingSize,
    required this.calories,
    required this.fat,
    required this.saturatedFat,
    required this.transFat,
    required this.cholesterol,
    required this.sodium,
    required this.carbohydrate,
    required this.fiber,
    required this.sugar,
    required this.protein,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json['id'] ?? 0,
        foodName: json['food_name'] ?? '',
        foodImage: json['food_image'] ?? '',
        foodRating: json['food_rating'] ?? '',
        servingUnitName: json['serving_unit_name'] ?? '',
        servingSize: json['serving_size'] ?? '',
        calories: json['calories'] ?? 0,
        fat: json['fat'] ?? 0,
        saturatedFat: json['saturated_fat'] ?? 0,
        transFat: json['trans_fat'] ?? 0,
        cholesterol: json['cholesterol'] ?? 0,
        sodium: json['sodium'] ?? 0,
        carbohydrate: json['carbohydrate'] ?? 0,
        fiber: json['fiber'] ?? 0,
        sugar: json['sugar'] ?? 0,
        protein: json['protein'] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "food_name": foodName,
        "food_image": foodImage,
        "food_rating": foodRating,
        "serving_unit_name": servingUnitName,
        "serving_size": servingSize,
        "calories": calories,
        
       
      };
}
