class APIResponse {
  final int statusCode;
  final Map<String, dynamic>? data;

  APIResponse({
    required this.statusCode,
    required this.data,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
      statusCode: json['statusCode'],
      data: json['data'],
    );
  }

  factory APIResponse.failure(int code) =>
      APIResponse(statusCode: code, data: null);
}
