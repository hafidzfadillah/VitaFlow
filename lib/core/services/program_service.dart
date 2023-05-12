import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/program/program_model.dart';

class ProgramService {
  BaseAPI api;
  ProgramService(this.api);

  Future<ApiResultList<ProgramModel>> getPrograms() async {
    APIResponse response = await api.get(api.endpoint.getProgram);

    print(response.data);

    return ApiResultList<ProgramModel>.fromJson(response.data,
        (data) => data.map((e) => ProgramModel.fromJson(e)).toList(), "data");
  }
}
