import 'dart:io';

import 'package:dio/dio.dart';
import 'package:vitaflow/core/data/api.dart';
import 'package:vitaflow/core/data/base_api_impl.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
import 'package:vitaflow/injection.dart';
import 'package:vitaflow/navigation/navigation_utils.dart';

class BaseAPI implements BaseAPIImpl {
  Dio? _dio;
  final endpoint = locator<Api>();

  /// Initialize constructors
  BaseAPI({Dio? dio}) {
    _dio = dio ?? Dio();
  }
  Options getHeaders({String token = "" , bool? useToken}) {
    var header = <String, dynamic>{};
    header['Accept'] = 'application/json';
    header['Content-Type'] = 'application/json';
    if (useToken == true) {
      header['Authorization'] = 'Bearer $token';
    }
    return Options(
      headers: header,
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
  }

  @override
  Future<APIResponse> delete(String url,
      {Map<String, dynamic>? param, bool? useToken}) async {
    try {
      final result = await _dio?.delete(url,
          options: getHeaders(useToken: useToken), queryParameters: param);
      return _parseResponse(result);
    } on DioError catch (e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> get(String url,
      {Map<String, dynamic>? param, bool? useToken , String? token ,data }) async {
    try {
      final result = await _dio?.get(url,
          data:  data,
          options: getHeaders(useToken: useToken,token:  token ?? ''), queryParameters: param);
      return _parseResponse(result);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        ConnectionProvider.instance(navigate.navigatorKey.currentContext!)
            .setConnection(false);
      } else {
        if (Platform.environment.containsKey('FLUTTER_TEST') == false) {
          ConnectionProvider.instance(navigate.navigatorKey.currentContext!)
              .setConnection(true);
        }
      }
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> post(String url,
      {Map<String, dynamic>? param, data, bool? useToken , String? token}) async {
    try {
      final result = await _dio?.post(url,
          options: getHeaders(useToken: useToken , token:  token ?? ''),
          data: data,
          queryParameters: param);
      return _parseResponse(result);
    } on DioError catch (e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  @override
  Future<APIResponse> put(String url,
      {Map<String, dynamic>? param, data, bool? useToken}) async {
    try {
      final result = await _dio?.put(url,
          options: getHeaders(useToken: useToken),
          data: data,
          queryParameters: param);
      return _parseResponse(result);
    } on DioError catch (e) {
      return APIResponse.failure(e.response?.statusCode ?? 500);
    }
  }

  Future<APIResponse> _parseResponse(Response? response) async {
    return APIResponse.fromJson({
      'statusCode': response?.statusCode,
      'data': response?.data,
    });
  }
}
