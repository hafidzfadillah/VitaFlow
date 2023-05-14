import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/message/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  BaseAPI api;
  ChatService(this.api);

  Future<ApiResult<MessageModel>> sendMessage(String message) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    APIResponse response = await api
        .post(api.endpoint.vitabot, useToken: true, token: token, data: {
      "text": message,
    });

    print(response.data);

    return ApiResult<MessageModel>.fromJson(
        response.data, (data) => MessageModel.fromJson(data), "data");
  }
}
