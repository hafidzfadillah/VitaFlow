import 'package:vitaflow/core/models/api/api_result_model.dart';

class StepModel extends Serializable {
  final DateTime date;
  final int value;

  StepModel({required this.date, required this.value});

  factory StepModel.fromJson(Map<String, dynamic> json) => StepModel(
        date: DateTime.parse(json['date']),
        value: json['value'] ?? 0,
      );

  @override
  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "value": value,
      };
}
