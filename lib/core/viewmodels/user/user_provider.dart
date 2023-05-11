import 'package:flutter/material.dart';
import 'package:vitaflow/core/models/mission/my_mission.dart';
import 'package:vitaflow/core/models/nutrion/nutrion_mode.dart';
import 'package:vitaflow/core/models/user/user_model.dart';
import 'package:vitaflow/core/services/user_service.dart';
import 'package:vitaflow/injection.dart';

class UserProvider extends ChangeNotifier {
  // Dependency Injection
  final userService = locator<UserService>();

  // Property to check mounted before notify
  bool isDisposed = false;

  // Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  // User data
  UserModel? _user;
  UserModel? get user => _user;

  // Nutrition data
  NutrionModel? _myNutrition;
  NutrionModel? get myNutrition => _myNutrition;

  // Nutrition data
  List<MyMissionModel>? _myMission;
  List<MyMissionModel>? get myMission => _myMission;

  // Login function
  Future<bool> login(String email, String password) async {
    setOnSearch(true);
    try {
      final result = await userService.login(email, password);
      if (result.data.id != null) {
        _user = result.data;
        return true;
      } else {
        return false;
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      return false;
    }
  }

  // Daftar function
  Future<bool> daftar(String name, String email, String password) async {
    setOnSearch(true);
    try {
      final result = await userService.daftar(name, email, password);
      if (result.data.id != null) {
        _user = result.data;
        return true;
      } else {
        return false;
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      return false;
    }
  }

  Future<void> getNutrion() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await userService.getUserNutrition();

      if (result.data.date != null) {
        _myNutrition = result.data;
      } else {
        _myNutrition = NutrionModel(
            date: DateTime.now().toString().substring(0, 10),
            targetCalories: 0,
            calorieLeft: 0,
            activityCalories: 0,
            carbohydrate: 0,
            protein: 0,
            fat: 0,
            intakeCalories: 0,
            proteinPercentage: 0,
            carbPercentage: 0,
            fatPercentage: 0,
            akg: 0);
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _myNutrition = NutrionModel(
          date: DateTime.now().toString().substring(0, 10),
          targetCalories: 0,
          calorieLeft: 0,
          activityCalories: 0,
          carbohydrate: 0,
          protein: 0,
          fat: 0,
          intakeCalories: 0,
          proteinPercentage: 0,
          carbPercentage: 0,
          fatPercentage: 0,
          akg: 0);
    }
    setOnSearch(false);
  }

  Future<void> getMyMission() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await userService.getUserMission();

      print(result.data);

      if (result.data!.isNotEmpty) {
        print('mssion success');
        _myMission = result.data;
      } else {
        _myMission = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _myMission = [];
    }
    setOnSearch(false);
  }

  // Set event login
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}
