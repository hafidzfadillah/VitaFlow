import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/exercise/exercise_model.dart';
import 'package:vitaflow/core/models/foods/food_lite.dart';

class ExerciseService {
  BaseAPI api;
  ExerciseService(this.api);

  Future<ApiResultList<ExerciseModel>> getExercise() async {
    APIResponse response = await api.get(api.endpoint.getExercise);
    print(response.data);
    return ApiResultList<ExerciseModel>.fromJson(response.data,
        (data) => data.map((e) => ExerciseModel.fromJson(e)).toList(), "data");
  }

  Future<ApiResultList<ExerciseModel>> searchExercise(String keyword) async {
    APIResponse response =
        await api.post(api.endpoint.searchExercise, data: {"search": keyword});
    return ApiResultList<ExerciseModel>.fromJson(response.data,
        (data) => data.map((e) => ExerciseModel.fromJson(e)).toList(), "data");
  }
}
