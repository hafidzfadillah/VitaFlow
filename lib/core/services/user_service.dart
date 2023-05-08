import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/mission/my_mission.dart';
import 'package:vitaflow/core/models/nutrion/nutrion_model.dart';
import 'package:vitaflow/core/models/user/user_drink.dart';
import 'package:vitaflow/core/models/user/user_food.dart';
import 'package:vitaflow/core/models/user/user_model.dart';

class UserService {
  BaseAPI api;
  UserService(this.api);
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', userData['access_token']);
    await prefs.setInt('id', userData['user']['id']);
    await prefs.setString('name', userData['user']['name']);
    await prefs.setString('email', userData['user']['email']);
    await prefs.setString('created_at', userData['user']['created_at']);
    await prefs.setString('updated_at', userData['user']['updated_at']);
    await prefs.setInt('age', userData['user']['age']);
    await prefs.setString('gender', userData['user']['gender']);
    await prefs.setInt('height', userData['user']['height']);
    await prefs.setInt('weight', userData['user']['weight']);
    await prefs.setDouble('bmi', userData['user']['bmi']);
    await prefs.setString('goal', userData['user']['goal']);
    await prefs.setInt('target_weight', userData['user']['target_weight']);
    await prefs.setInt(
        'recommend_calories', userData['user']['recommend_calories']);
    await prefs.setInt('point', userData['user']['point']);
  }

  Future<ApiResult<UserModel>> login(String email, String password) async {
    Map<String, dynamic> data = {"email": email, "password": password};
    APIResponse response = await api.post(api.endpoint.login, data: data);

    final userData = response.data;

    // Save user data to shared preference.
    await saveUserData(userData!);

    return ApiResult<UserModel>.fromJson(
        userData, (data) => UserModel.fromJson(data), "user");
  }

  Future<ApiResult<NutrionModel>> getUserNutrition({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.getDailyData,
        useToken: true, token: token, data: {"date": dateStr});

    return ApiResult<NutrionModel>.fromJson(response.data?['data'],
        (data) => NutrionModel.fromJson(data), "my_nutrion");
  }

  Future<ApiResultList<MyMissionModel>> getUserMission({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.getDailyData,
        useToken: true, token: token, data: {"date": dateStr});

    return ApiResultList<MyMissionModel>.fromJson(
        response.data?['data'],
        (data) => data.map((e) => MyMissionModel.fromJson(e)).toList(),
        "my_missions");
  }

  Future<ApiResultList<UserDrinkModel>?> storeDrink() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response =
        await api.post(api.endpoint.storeDrink, useToken: true, token: token);

    if (response.statusCode == 200) {
      final data = response.data;
      final userDrink = ApiResultList<UserDrinkModel>.fromJson(
          data,
          (data) => data.map((e) => UserDrinkModel.fromJson(e)).toList(),
          "data");

      return userDrink;
    } else {
      return null;
    }
  }

  Future<ApiResultList<UserDrinkModel>> getUserHistoryDrink(
      {DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.historyDrink,
        useToken: true, token: token, data: {"date": dateStr});
    print(response.data);

    return ApiResultList<UserDrinkModel>.fromJson(response.data,
        (data) => data.map((e) => UserDrinkModel.fromJson(e)).toList(), "data");
  }

  Future<ApiResultList<UserFood>> getUserHistoryMeal({DateTime? date}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    String dateStr = DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());

    APIResponse response = await api.get(api.endpoint.historyFood,
        useToken: true, token: token, data: {"date": dateStr});

    print(response.data);
    return ApiResultList<UserFood>.fromJson(response.data?['data'],
        (data) => data.map((e) => UserFood.fromJson(e)).toList(), "foods");
  }
}
