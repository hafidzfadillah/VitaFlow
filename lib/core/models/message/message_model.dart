import 'package:vitaflow/core/models/api/api_result_model.dart';

class MessageModel extends Serializable {
  final String role;
  final String message;
  MessageModel({
    required this.role,
    required this.message,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      MessageModel(role: json['role'] ?? '', message: json['message'] ?? "");

  @override
  Map<String, dynamic> toJson() => {
        "role": role,
        "message": message,
      };
}
