import '../api/api_result_model.dart';

class ProgramModel extends Serializable {
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

  ProgramModel(
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

  factory ProgramModel.fromJson(Map<String, dynamic> json) => ProgramModel(
        id: json['id'],
        programName: json['program_name'],
        programDescription: json['program_description'],
        programDuration: json['program_duration'],
        programGoalWeight: json['program_goal_weight'],
        programType: json['program_type'],
        image: json['image'],
        bmiMin: json['bmi_min'],
        bmiMax: json['bmi_max'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  @override
  Map<String, dynamic> toJson() => {
    "id":id,
    "program_name":programName,
    "program_description":programDescription,
    "program_duration":programDuration,
    "program_goal_weight":programGoalWeight,
    "program_type":programType,
    "image":image,
    "bmi_min":bmiMin,
    "bmi_max":bmiMax,
    "created_at":createdAt,
    "updated_at":updatedAt
  };
}
