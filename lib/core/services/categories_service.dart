import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/category/category_model.dart';

class CategoryService {
  BaseAPI api;
  CategoryService(this.api);

  Future<ApiResultList<CategoryModel>> getCategories() async {
    APIResponse response = await api.get(api.endpoint.getCategories);

    return ApiResultList<CategoryModel>.fromJson(response.data,
        (data) => data.map((e) => CategoryModel.fromJson(e)).toList(), "data");
  }
}
