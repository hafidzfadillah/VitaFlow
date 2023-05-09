import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/core/models/foods/food_lite.dart';
import 'package:vitaflow/core/models/mission/my_mission.dart';
import 'package:vitaflow/core/models/nutrion/nutrion_model.dart';
import 'package:vitaflow/core/models/user/user_food.dart';
import 'package:vitaflow/core/models/user/user_model.dart';
import 'package:vitaflow/core/services/user_service.dart';
import 'package:vitaflow/injection.dart';

import '../../models/user/user_drink.dart';

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

  // User drink data
  List<UserDrinkModel>? _userDrink;
  List<UserDrinkModel>? get userDrink => _userDrink;

  // user food data
  List<UserFood>? _userLunchFood;
  List<UserFood>? get userLunchFood => _userLunchFood;

  List<UserFood>? _userDinnerFood;
  List<UserFood>? get userDinnerFood => _userDinnerFood;

  List<UserFood>? _userBreakfastFood;
  List<UserFood>? get userBreakfastFood => _userBreakfastFood;

  List<UserFood>? _userSnacks;
  List<UserFood>? get userSnacks => _userSnacks;


  List<String> _searchHistory = [];
  List<String> get searchHistory => _searchHistory;



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

  Future<void> getNutrion({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);

    final selectedDate = date ?? DateTime.now();

    // Initialize DateFormatting for the default locale
    await initializeDateFormatting();

    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    try {
      final result = await userService.getUserNutrition(date: date);

      if (result.data.date != null) {
        _myNutrition = result.data;
      } else {
        _myNutrition = NutrionModel(
            date: formattedDate,
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
          date: formattedDate,
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

  Future<void> getMyMission({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);

    final selectedDate = date ?? DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    try {
      final result = await userService.getUserMission(date: date);

      if (result.data!.isNotEmpty) {
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

  Future<void> getUserFood({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);

    final selectedDate = date ?? DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    try {
      final result = await userService.getUserHistoryMeal(date: date);

      if (result.data!.isNotEmpty) {
        _userLunchFood = [];
        _userDinnerFood = [];
        _userBreakfastFood = [];
        _userSnacks = [];

        for (final data in result.data!) {
          if (data.mealType == "lunch") {
            _userLunchFood!.add(UserFood(
              mealType: data.mealType,
              foodName: data.foodName,
              calorieIntake: data.calorieIntake,
              carbohydrateIntake: data.carbohydrateIntake,
              proteinIntake: data.proteinIntake,
              fatIntake: data.fatIntake,
              size: data.size,
              unit: data.unit,
            ));
          } else if (data.mealType == "dinner") {
            _userDinnerFood!.add(UserFood(
              mealType: data.mealType,
              foodName: data.foodName,
              calorieIntake: data.calorieIntake,
              carbohydrateIntake: data.carbohydrateIntake,
              proteinIntake: data.proteinIntake,
              fatIntake: data.fatIntake,
              size: data.size,
              unit: data.unit,
            ));
          } else if (data.mealType == "breakfast") {
            _userBreakfastFood!.add(UserFood(
              mealType: data.mealType,
              foodName: data.foodName,
              calorieIntake: data.calorieIntake,
              carbohydrateIntake: data.carbohydrateIntake,
              proteinIntake: data.proteinIntake,
              fatIntake: data.fatIntake,
              size: data.size,
              unit: data.unit,
            ));
          } else if (data.mealType == "snack") {
            _userSnacks!.add(UserFood(
              mealType: data.mealType,
              foodName: data.foodName,
              calorieIntake: data.calorieIntake,
              carbohydrateIntake: data.carbohydrateIntake,
              proteinIntake: data.proteinIntake,
              fatIntake: data.fatIntake,
              size: data.size,
              unit: data.unit,
            ));
          }
        }
      } else {
        // handle empty data
        _userLunchFood = [];
        _userDinnerFood = [];
        _userBreakfastFood = [];
        _userSnacks = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _userLunchFood = [];
      _userDinnerFood = [];
      _userBreakfastFood = [];
      _userSnacks = [];
    }

    setOnSearch(false);
  }
// Future<void> addDrink() async {
//     final lastDrink = _userDrink?.isEmpty == true ? null : _userDrink!.last;
//     final now = DateTime.now();
//     final lastValue = lastDrink?.value ?? 0;
//     final newDrink = UserDrinkModel(
//       id: lastDrink?.id + 1  ,
//       date: now,
//       value: lastValue + 1,
//       createdAt: now,
//     );

//     _userDrink?.add(newDrink);

//     notifyListeners();

//     try {
//       final result = await userService.StoreDrink();
//       if (result == false) {
//         _userDrink?.removeLast();
//         notifyListeners();
//       }
//     } catch (e, stacktrace) {
//       debugPrint("Error: ${e.toString()}");
//       debugPrint("Stacktrace: ${stacktrace.toString()}");
//       _userDrink?.removeLast();
//       notifyListeners();
//     }
//   }

  void storeDrink() async {
    setOnSearch(true);

    notifyListeners();
    try {
      final result = await userService.storeDrink();

      if (result?.message == 'Success') {
        _userDrink = result?.data;
      }

      notifyListeners();
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }
    setOnSearch(false);
  }

  Future<void> getUserHistoryDrink({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);

    final selectedDate = date ?? DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    try {
      final result = await userService.getUserHistoryDrink(date: date);
      if (result.data!.isNotEmpty) {
        _userDrink = result.data;
      } else {
        _userDrink = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _userDrink = [];
    }
    setOnSearch(false);
  }

  void storeFoods(List<FoodLiteModel> foods, String mealType) async {
    try {
      await userService.storeFoods(mealType, foods);

      notifyListeners();
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }
    setOnSearch(false);
  }
  

  Future<void> searchLastSearch(String keyword) async {
    if (_searchHistory.contains(keyword)) return;

    _searchHistory.add(keyword);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('search_history', _searchHistory.toList());

    notifyListeners();
  }

  Future<void> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('search_history') ?? [];

    _searchHistory =  history.toSet().toList();

    notifyListeners();
  }


  // Set event login
  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  // clear my nutrition
  void clearMyNutrition() {
    _myNutrition = null;
    notifyListeners();
  }

  // clear my mission
  void clearMyMission() {
    _myMission = null;
    notifyListeners();
  }

  // clear my drink
  void clearMyDrink() {
    _userDrink = null;
    notifyListeners();
  }

  void clearMyFood() {
    _userLunchFood = null;
    _userDinnerFood = null;
    _userBreakfastFood = null;
    _userSnacks = null;
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
