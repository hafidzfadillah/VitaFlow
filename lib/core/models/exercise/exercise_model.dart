import 'package:vitaflow/core/models/api/api_result_model.dart';

class ExerciseModel extends Serializable {
  final int id;
  final String exerciseName;
  final String exerciseVideoUrl;
  final String exerciseDescription;
  final int exerciseDuration;
  final int exerciseRepetition;
  final int caloriesBurnedEstimate;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExerciseModel({
    required this.id,
    required this.exerciseName,
    required this.exerciseVideoUrl,
    required this.exerciseDescription,
    required this.exerciseDuration,
    required this.exerciseRepetition,
    required this.caloriesBurnedEstimate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
        id: json['id'] ?? 0,
        exerciseName: json['exercise_name'] ?? "",
        exerciseVideoUrl: json['exercise_video_url'] ?? "",
        exerciseDescription: json['exercise_description'] ?? "",
        exerciseDuration: json['exercise_duration'] ?? 0,
        exerciseRepetition: json['exercise_repetition'] ?? 0,
        caloriesBurnedEstimate: json['calories_burned_estimate'] ?? 0,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "exercise_name": exerciseName,
        "exercise_video_url": exerciseVideoUrl,
        "exercise_description": exerciseDescription,
        "exercise_duration": exerciseDuration,
        "exercise_repetition": exerciseRepetition,
        "calories_burned_estimate": caloriesBurnedEstimate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
