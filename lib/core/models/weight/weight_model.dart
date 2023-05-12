import 'package:vitaflow/core/models/api/api_result_model.dart';

class WeightModel extends Serializable {
  final DateTime date;
  final int value;
  final DateTime createdAt;
  WeightModel({
    required this.date,
    required this.value,
    required this.createdAt,
  });

  factory WeightModel.fromJson(Map<String, dynamic> json) => WeightModel(
        date: DateTime.parse(json['date']),
        value: json['value'] ?? 0,
        createdAt: DateTime.parse(json['created_at']),
      );

  @override
  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "value": value,
        "created_at": createdAt.toIso8601String(),
      };
}
