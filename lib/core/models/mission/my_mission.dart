import 'package:vitaflow/core/models/api/api_result_model.dart';

class MyMissionModel  extends Serializable{
  final String name;
  final String description;
  final String icon;
  final int colorTheme;
  final int point;
  final int target;
  final int current;
  final String typeTarget;
  final String status;
  final String date;
  final num percentageSuccess;

  MyMissionModel({
    required this.name,
    required this.description,
    required this.icon,
    required this.colorTheme,
    required this.point,
    required this.target,
    required this.current,
    required this.typeTarget,
    required this.status,
    required this.date,
    required this.percentageSuccess,
  });

  factory MyMissionModel.fromJson(Map<String, dynamic> json) => MyMissionModel(
        name: json['name'] ?? "",
        description: json['description'] ?? "",
        icon: json['icon'] ?? "",
        colorTheme: int.parse(json['color_theme'] ?? "0"),
        point: json['point'] ?? 0,
        target: json['target'] ?? 0,
        current: json['current'] ?? 0,
        typeTarget: json['type_target'] ?? "",
        status: json['status'] ?? "",
        date: json['date'] ?? "",
        percentageSuccess: json['percentange_success'] ?? 0,
      );
  @override
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "icon": icon,
        "color_theme": colorTheme.toString(),
        "point": point,
        "target": target,
        "current": current,
        "type_target": typeTarget,
        "status": status,
        "date": date,
        "percentange_success": percentageSuccess,
      };
}
