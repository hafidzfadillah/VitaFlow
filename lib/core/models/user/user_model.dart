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
  final num bmi;
  final String goal;
  final int targetWeight;
  final num recommendCalories;
  final int point;
  final int isPremium;
  final DateTime? premiumExpiredAt;
  final int credit;


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
    required this.isPremium,
    this.premiumExpiredAt,
    required this.credit,

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
        bmi: json['bmi'] ?? 0.0,
        goal: json['goal'] ?? "",
        targetWeight: json['target_weight'] ?? 0,
        recommendCalories: json['recommend_calories'] ?? 0,
        point: json['point'] ?? 0,
        isPremium: json['is_premium'] ?? 0,
        premiumExpiredAt: json['premium_expired_at'] != null
            ? DateTime.parse(json['premium_expired_at'])
            : null,
        credit: json['credit'] ?? 0,
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
        "is_premium": isPremium,
        "premium_expired_at": premiumExpiredAt?.toIso8601String(),
        "credit": credit,
      };
}
