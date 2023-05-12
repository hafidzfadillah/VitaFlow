import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/message/message_model.dart';

class ChatService {
  BaseAPI api;
  ChatService(this.api);

  Future<ApiResult<MessageModel>> sendMessage(String message) async {
    print(message);
    APIResponse response = await api.post(api.endpoint.vitabot, data: {
      "text": message,
    });

    return ApiResult<MessageModel>.fromJson(
        response.data, (data) => MessageModel.fromJson(data), "data");
  }
}
