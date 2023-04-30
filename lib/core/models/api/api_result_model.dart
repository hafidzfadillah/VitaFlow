class ApiResult<T extends Serializable> {
  String? status;
  T data;
  ApiResult({
    required this.status,
    required this.data,
  });

  factory ApiResult.fromJson(Map<String, dynamic>? json,
      Function(Map<String, dynamic>) create, String field) {
    return ApiResult<T>(
      status: json?['status'] ?? '',
      data: json?[field] != null && json?[field] is Map
          ? create(json?[field] ?? {})
          : create({}),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class ApiResultList<T extends Serializable> {
  String? status;
  List<T>? data;

  ApiResultList({this.status ,this.data});

  factory ApiResultList.fromJson(
      Map<String, dynamic>? json, Function(List<dynamic>) build, String field) {
    return ApiResultList<T>(
      status: json?['status'] ?? false,
      data: json?[field] != null && json?[field] is List
          ? build(json?[field])
          : build([]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toList(),
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
