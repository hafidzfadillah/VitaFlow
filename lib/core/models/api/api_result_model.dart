class ApiResult<T extends Serializable> {
  String? status;
   String? message;
  T data;
  ApiResult({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResult.fromJson(Map<String, dynamic>? json,
      Function(Map<String, dynamic>) create, String field) {
    return ApiResult<T>(
      status: json?['status'] ?? '',
      message: json?['message'] ?? '',
      data: json?[field] != null && json?[field] is Map
          ? create(json?[field] ?? {})
          : create({}),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ApiResultList<T extends Serializable> {
  String? status;
  String? message;
  List<T>? data;

  ApiResultList({this.status ,
  this.message,
  
  this.data});

  factory ApiResultList.fromJson(
      Map<String, dynamic>? json, Function(List<dynamic>) build, String field) {
    return ApiResultList<T>(
      status: json?['status'] ?? 'false',
      message: json?['message'] ?? '',
      data: json?[field] != null && json?[field] is List
          ? build(json?[field])
          : build([]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toList(),
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
