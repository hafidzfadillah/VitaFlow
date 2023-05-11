import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/core/data/base_api.dart';
import 'package:vitaflow/core/models/survey/survey_model.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';

import '../models/api/api_response.dart';
import '../models/api/api_result_model.dart';
import '../models/user/user_model.dart';

class SurveyService {
  BaseAPI api;

  SurveyService(this.api);

  Future<ApiResult<SurveyModel>> submitData(SurveyProvider s) async {
    String gender = s.gender == Gender.Pria ? "laki-laki" : "perempuan";
    int umur = s.umur;

    var height = s.tinggi;
    var weight = s.berat;
    var target = s.targetBB;

    if (s.heightFormat == HeightFormat.ft) {
      height = (height * 30.48).round();
    }

    if (s.weightFormat == WeightFormat.lbs) {
      weight = (weight / 2.2).round();
      target = (weight / 2.2).round();
    }

    String goal = "maintain";
    if (s.tujuan.toLowerCase().contains("naik")) {
      goal = "gain";
    } else if (s.tujuan.toLowerCase().contains("nurun")) {
      goal = "less";
    }

    Map<String, dynamic> data = {
      "gender": gender,
      "goal": goal,
      "age": umur,
      "height": height,
      "weight": weight,
      "target_weight": target,
    };

    print(data);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    print("TOKEN : $token");

    APIResponse response = await api.post(api.endpoint.submitSurvey,
        useToken: true, token: token, data: data);

    final resultData = response.data;
    print("response: $resultData");

    return ApiResult<SurveyModel>.fromJson(
        resultData, (data) => SurveyModel.fromJson(data), "data");
  }
}
