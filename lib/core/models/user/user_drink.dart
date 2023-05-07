import 'package:vitaflow/core/models/api/api_result_model.dart';

class UserDrinkModel extends Serializable {
  final int id;

  final DateTime date;
  final int value;
  final DateTime createdAt;

  UserDrinkModel({
    required this.id,
    required this.date,
    required this.value,
    required this.createdAt,
  });

  factory UserDrinkModel.fromJson(Map<String, dynamic> json) =>
      UserDrinkModel(
        id: json['id'] ?? 0,
        date: DateTime.parse(json['date']),
        value: json['value'] ?? 0,
        createdAt: DateTime.parse(json['created_at']),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "value": value,
        
        
      };
}
