import 'package:vitaflow/core/models/api/api_result_model.dart';

class UserModel extends Serializable {
  final int id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int age;
  final String gender;
  final int height;
  final int weight;
  final double bmi;
  final String goal;
  final int targetWeight;
  final int recommendCalories;
  final int point;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.goal,
    required this.targetWeight,
    required this.recommendCalories,
    required this.point,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        emailVerifiedAt: json['email_verified_at'] != null
            ? DateTime.parse(json['email_verified_at'])
            : null,
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        age: json['age'] ?? 0,
        gender: json['gender'] ?? "",
        height: json['height'] ?? 0,
        weight: json['weight'] ?? 0,
        bmi: json['bmi'] ?? 0,
        goal: json['goal'] ?? "",
        targetWeight: json['target_weight'] ?? 0,
        recommendCalories: json['recommend_calories'] ?? 0,
        point: json['point'] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "age": age,
        "gender": gender,
        "height": height,
        "weight": weight,
        "bmi": bmi,
        "goal": goal,
        "target_weight": targetWeight,
        "recommend_calories": recommendCalories,
        "point": point,
      };

      
}
