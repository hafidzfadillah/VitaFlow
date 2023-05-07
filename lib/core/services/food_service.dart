import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/foods/food_lite.dart';

class FoodService {
  BaseAPI api;
  FoodService(this.api);

  Future<ApiResultList<FoodLiteModel>> getFoods() async {
    APIResponse response = await api.get(api.endpoint.getFoods);

    return ApiResultList<FoodLiteModel>.fromJson(response.data,
        (data) => data.map((e) => FoodLiteModel.fromJson(e)).toList(), "data");
  }

  Future<ApiResultList<FoodLiteModel>> searchFoods(String keyword) async {
    print('asd'+keyword);
    APIResponse response =
        await api.post(api.endpoint.searchFood, data: {"search": keyword});
    return ApiResultList<FoodLiteModel>.fromJson(response.data,
        (data) => data.map((e) => FoodLiteModel.fromJson(e)).toList(), "data");
  }
}
