import 'package:vitaflow/core/models/api/api_result_model.dart';

class UserFood  extends Serializable {
  String mealType;
  String foodName;
  int calorieIntake;
  int carbohydrateIntake;
  int proteinIntake;
  int fatIntake;
  int size;
  String unit;

  UserFood({
    required this.mealType,
    required this.foodName,
    required this.calorieIntake,
    required this.carbohydrateIntake,
    required this.proteinIntake,
    required this.fatIntake,
    required this.size,
    required this.unit,
  });

  factory UserFood.fromJson(Map<String, dynamic> json) {
    return UserFood(
      mealType: json['meal_type'],
      foodName: json['food_name'],
      calorieIntake: json['calorie_intake'],
      carbohydrateIntake: json['carbohydrate_intake'],
      proteinIntake: json['protein_intake'],
      fatIntake: json['fat_intake'],
      size: json['size'],
      unit: json['unit'],
    );
  }
  
  @override
  Map<String, dynamic> toJson() => {
        "meal_type": mealType,
        "food_name": foodName,
        "calorie_intake": calorieIntake,
        "carbohydrate_intake": carbohydrateIntake,
        "protein_intake": proteinIntake,
        "fat_intake": fatIntake,
        "size": size,
        "unit": unit,
      };

}

