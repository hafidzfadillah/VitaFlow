import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/core/models/survey/survey_model.dart';
import 'package:vitaflow/core/services/survey_services.dart';

import '../../../injection.dart';

enum Gender { Pria, Wanita }

enum HeightFormat { cm, ft }

enum WeightFormat { kg, lbs }

class SurveyProvider extends ChangeNotifier {
  SurveyModel? _survey;
  SurveyModel? get survey => _survey;

  Gender _gender = Gender.Pria;
  HeightFormat _heightFormat = HeightFormat.cm;
  WeightFormat _weightFormat = WeightFormat.kg;
  String _tujuan = "";
  int _umur = 1;
  int _tingi = 1, _berat = 1, _targetBB = 1;

  Gender get gender => _gender;
  set gender(Gender value) {
    _gender = value;
    notifyListeners();
  }

  HeightFormat get heightFormat => _heightFormat;
  set heightFormat(HeightFormat value) {
    _heightFormat = value;
    notifyListeners();
  }

  WeightFormat get weightFormat => _weightFormat;
  set weightFormat(WeightFormat value) {
    _weightFormat = value;
    notifyListeners();
  }

  String get tujuan => _tujuan;
  set tujuan(String value) {
    _tujuan = value;
    notifyListeners();
  }

  int get umur => _umur;
  set umur(int value) {
    _umur = value;
    notifyListeners();
  }

  int get tinggi => _tingi;
  set tinggi(int value) {
    _tingi = value;
    notifyListeners();
  }

  int get berat => _berat;
  set berat(int value) {
    _berat = value;
    notifyListeners();
  }

  int get targetBB => _targetBB;
  set targetBB(int value) {
    _targetBB = value;
    notifyListeners();
  }

  void result() {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        msg: 'Survey{ gender = ${_gender.name}, age = $_umur, tujuan = $_tujuan,' +
            ' tinggi = $_tingi ${_heightFormat.name}, berat = $_berat ${_weightFormat.name}, targetBB = $_targetBB ${_weightFormat.name}}');
  }

  final surveyService = locator<SurveyService>();
  Future<SurveyModel?> store() async {
    try {
      print("Age: ${this._umur}");
      final result = await surveyService.submitData(this);
      print("Result Data : ${result.data.dailyCalories}");

      if (result.data != null) {
        _survey = result.data;
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }

    return _survey;
  }
}
