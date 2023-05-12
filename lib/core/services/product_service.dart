import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/product/product_model.dart';

class ProductService {
  BaseAPI api;
  ProductService(this.api);

  Future<ApiResultList<ProductModel>> getProducts({int? categoryId}) async {
    Map<String, dynamic> params =
        categoryId != null ? {"category": categoryId} : {};

    APIResponse response =
        await api.get(api.endpoint.getProductsByCategory, param: params);
    print(response.data);

    return ApiResultList<ProductModel>.fromJson(response.data,
        (data) => data.map((e) => ProductModel.fromJson(e)).toList(), "data");
  }

  Future<ApiResultList<ProductModel>> searchProduct(
      String keyword) async {
    APIResponse response =
        await api.post(api.endpoint.searchProduct, data: {"search": keyword});
    return ApiResultList<ProductModel>.fromJson(
        response.data,
        (data) => data.map((e) => ProductModel.fromJson(e)).toList(),
        "data");
  }
}
