import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/bpm/bpm_model.dart';

class HealthDataModel extends Serializable {
  final List<BpmModel> healthData;
  final List<BpmModel> chart;
  final double averageBpm;

  HealthDataModel({
    required this.healthData,
    required this.chart,
    required this.averageBpm,
  });

  factory HealthDataModel.fromJson(Map<String, dynamic> json) {
    List<BpmModel> healthDataList = [];
    List<BpmModel> chartList = [];

    List<dynamic> healthDataJsonList = json['health_data'];
    for (dynamic healthDataJson in healthDataJsonList) {
      healthDataList.add(BpmModel.fromJson(healthDataJson));
    }

    List<dynamic> chartJsonList = json['chart'];
    for (dynamic chartJson in chartJsonList) {
      chartList.add(BpmModel.fromJson(chartJson));
    }

    return HealthDataModel(
      healthData: healthDataList,
      chart: chartList,
      averageBpm: json['average_bpm']?.toDouble() ?? 0.0,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "health_data": healthData.map((e) => e.toJson()).toList(),
        "chart": chart.map((e) => e.toJson()).toList(),
        "average_bpm": averageBpm,
      };
}
