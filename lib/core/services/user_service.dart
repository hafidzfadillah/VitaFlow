import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/api/api_response.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/mission/my_mission.dart';
import 'package:vitaflow/core/models/nutrion/nutrion_mode.dart';
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
    await prefs.setInt('age', userData['user']['age']  ?? 0);
    await prefs.setString('gender', userData['user']['gender'] ?? 'laki-laki');
    await prefs.setInt('height', userData['user']['height'] ?? 0);
    await prefs.setInt('weight', userData['user']['weight'] ?? 0);
    await prefs.setDouble('bmi', userData['user']['bmi'] ?? 0);
    await prefs.setString('goal', userData['user']['goal'] ?? 'maintain');
    await prefs.setInt('target_weight', userData['user']['target_weight'] ?? 0);
    await prefs.setInt(
        'recommend_calories', userData['user']['recommend_calories'] ?? 0);
    await prefs.setInt('point', userData['user']['point'] ?? 0);
  }

  Future<void> saveUserDaftar(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', userData['access_token']);
    await prefs.setInt('id', userData['user']['id']);
    await prefs.setString('name', userData['user']['name']);
    await prefs.setString('email', userData['user']['email']);
    await prefs.setString('created_at', userData['user']['created_at']);
    await prefs.setString('updated_at', userData['user']['updated_at']);
  }

  Future<ApiResult<UserModel>> login(String email, String password) async {
    Map<String, dynamic> data = {"email": email, "password": password};
    APIResponse response = await api.post(api.endpoint.login, data: data);

    final userData = response.data;

    print(userData?['access_token'] ?? 'no token');

    // Save user data to shared preference.
    await saveUserData(userData!);

    return ApiResult<UserModel>.fromJson(
        userData, (data) => UserModel.fromJson(data), "user");
  }

  Future<ApiResult<UserModel>> daftar(String name, String email, String password) async {
    Map<String, dynamic> data = {"name":name,"email": email, "password": password};
    APIResponse response = await api.post(api.endpoint.register, data: data);

    final userData = response.data;

    print(userData?['access_token'] ?? 'no token');

    // Save user data to shared preference.
    await saveUserDaftar(userData!);

    return ApiResult<UserModel>.fromJson(
        userData, (data) => UserModel.fromJson(data), "user");
  }

  Future<ApiResult<NutrionModel>> getUserNutrition() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response = await api.get(api.endpoint.getDailyData,
        useToken: true, token: token, data: {"date": "2023-05-02"});

    print('data ${response.data?['data']}');

    return ApiResult<NutrionModel>.fromJson(response.data?['data'],
        (data) => NutrionModel.fromJson(data), "my_nutrion");
  }

  Future<ApiResultList<MyMissionModel>> getUserMission() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    APIResponse response = await api.get(api.endpoint.getDailyData,
        useToken: true, token: token, data: {"date": "2023-05-02"});

    print('data ${response.data?['data']}');

    return ApiResultList<MyMissionModel>.fromJson(
        response.data?['data'],
        (data) => data.map((e) => MyMissionModel.fromJson(e)).toList(),
        "my_missions");
  }
}
