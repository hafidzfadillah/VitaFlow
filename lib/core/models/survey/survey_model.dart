import 'dart:convert';

import 'package:vitaflow/core/models/api/api_result_model.dart';

class SurveyModel extends Serializable {
  final num bmi;
  final num idealWeight;
  final num recommendedWeight;
  final num dailyCalories;
  final String bmiClassification;
  final String warning;
  final Programs? programs;

  SurveyModel(
      {required this.bmi,
      required this.idealWeight,
      required this.recommendedWeight,
      required this.dailyCalories,
      required this.bmiClassification,
      required this.warning,
      required this.programs});

  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
      bmi: json['bmi'] ?? 0.0,
      idealWeight: json['idealWeight'] ?? 0.0,
      recommendedWeight: json['recommendedWeight'] ?? 0.0,
      dailyCalories: json['dailyCalories'] ?? 0.0,
      bmiClassification: json['bmiClassification'] ?? "",
      warning: json['warning'] ?? "",
      programs: Programs.fromJson(json['programs']));

  @override
  Map<String, dynamic> toJson() => {
        "bmi": bmi,
        "idealWeight": idealWeight,
        "recommendedWeight": recommendedWeight,
        "dailyCalories": dailyCalories,
        "bmiClassification": bmiClassification,
        "warning": warning,
        "programs": programs,
      };
}

class Programs extends Serializable {
  final int id;
  final String programName;
  final String programDescription;
  final String programDuration;
  final String programGoalWeight;
  final String programType;
  final String image;
  final num bmiMin;
  final num bmiMax;
  final String createdAt;
  final String updatedAt;

  Programs(
      {required this.id,
      required this.programName,
      required this.programDescription,
      required this.programDuration,
      required this.programGoalWeight,
      required this.programType,
      required this.image,
      required this.bmiMin,
      required this.bmiMax,
      required this.createdAt,
      required this.updatedAt});

  factory Programs.fromJson(Map<String, dynamic> json) => Programs(
        id: json['id'] ?? 0,
        programName: json['program_name'] ?? "",
        programDescription: json['program_description'] ?? "",
        programDuration: json['program_duration'] ?? "",
        programGoalWeight: json['program_goal_weight'] ?? "",
        programType: json['program_type'] ?? "",
        image: json['image'] ?? "",
        bmiMin: json['bmi_min'] ?? 0.0,
        bmiMax: json['bmi_max'] ?? 0.0,
        createdAt: json['created_at'] ?? "",
        updatedAt: json['updated_at'] ?? "",
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "programName": programName,
        "programDescription": programDescription,
        "programDuration": programDuration,
        "programGoalWeight": programGoalWeight,
        "programType": programType,
        "image": image,
        "bmiMin": bmiMin,
        "bmiMax": bmiMax,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
