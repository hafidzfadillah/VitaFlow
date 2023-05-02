import 'package:vitaflow/core/models/api/api_result_model.dart';

class NutrionModel extends Serializable {
  final String date;
  final int targetCalories;
  final int calorieLeft;
  final int activityCalories;
  final int carbohydrate;
  final int protein;
  final int fat;
  final int intakeCalories;
  final int proteinPercentage;
  final int carbPercentage;
  final int fatPercentage;
  final int akg;

  NutrionModel({
    required this.date,
    required this.targetCalories,
    required this.calorieLeft,
    required this.activityCalories,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
    required this.intakeCalories,
    required this.proteinPercentage,
    required this.carbPercentage,
    required this.fatPercentage,
    required this.akg,
  });

  factory NutrionModel.fromJson(Map<String, dynamic> json) => NutrionModel(
        date: json['date'] ?? '',
        targetCalories: json['targetCalories'] ?? 0,
        calorieLeft: json['calorieLeft'] ?? 0,
        activityCalories: json['activityCalories'] ?? 0,
        carbohydrate: json['carbohydrate'] ?? 0,
        protein: json['protein'] ?? 0,
        fat: json['fat'] ?? 0,
        intakeCalories: json['intakeCalories'] ?? 0,
        proteinPercentage: json['proteinPercentage'] ?? 0.0,
        carbPercentage: json['carbPercentage'] ?? 0.0,
        fatPercentage: json['fatPercentage'] ?? 0.0,
        akg: json['akg'] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "date": date,
        "targetCalories": targetCalories,
        "calorieLeft": calorieLeft,
        "activityCalories": activityCalories,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
        "intakeCalories": intakeCalories,
        "proteinPercentage": proteinPercentage,
        "carbPercentage": carbPercentage,
        "fatPercentage": fatPercentage,
        "akg": akg,
      };
}
