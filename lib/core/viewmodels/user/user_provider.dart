import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/core/models/api/api_result_model.dart';
import 'package:vitaflow/core/models/bpm/bpm_model.dart';
import 'package:vitaflow/core/models/bpm/healt_data_model.dart';
import 'package:vitaflow/core/models/exercise/exercise_model.dart';
import 'package:vitaflow/core/models/foods/food_lite.dart';
import 'package:vitaflow/core/models/mission/my_mission.dart';
import 'package:vitaflow/core/models/nutrion/nutrion_model.dart';
import 'package:vitaflow/core/models/step/step_model.dart';
import 'package:vitaflow/core/models/transaction/transaction_model.dart';
import 'package:vitaflow/core/models/user/user_food.dart';
import 'package:vitaflow/core/models/user/user_model.dart';
import 'package:vitaflow/core/models/weight/weight_model.dart';
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

  // User drink data
  List<BpmModel>? _userBpm;
  List<BpmModel>? get userBpm => _userBpm;
  // User drink data
  List<WeightModel>? _userWeight;
  List<WeightModel>? get userWeight => _userWeight;
  // User step data
  List<StepModel>? _userStep;
  List<StepModel>? get userStep => _userStep;

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

  HealthDataModel? _healthData;
  HealthDataModel? get healthData => _healthData;
  // Daftar function
  Future<bool> daftar(String name, String email, String password) async {
    setOnSearch(true);
    try {
      final result = await userService.daftar(name, email, password);
      if (result.data.id != null) {
        _user = result.data;
        notifyListeners();
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

  Future<bool> getUserData() async {
    setOnSearch(true);
    try {
      final result = await userService.getUserData();
      if (result.data.id != null) {
        _user = result.data;
        notifyListeners();

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

  void storeBpm(int bpm) async {
    setOnSearch(true);

    notifyListeners();
    try {
      final result = await userService.storeBpm(
        bpm,
      );

      if (result?.message == 'Success') {
        _userBpm = result?.data;
      }

      notifyListeners();
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }
    setOnSearch(false);
  }

  void storeWeight(int weight) async {
    setOnSearch(true);

    notifyListeners();
    try {
      final result = await userService.storeWeight(
        weight,
      );

      if (result?.message == 'Success') {
        _userWeight = result?.data;
      }

      notifyListeners();
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }
    setOnSearch(false);
  }

  void storeStep(int step) async {
    setOnSearch(true);

    notifyListeners();
    try {
      final result = await userService.storeStep(
        step,
      );

      if (result?.message == 'Success') {
        _userStep = result?.data;
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

  Future<void> getUserHistoryHealth({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);

    final selectedDate = date ?? DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    try {
      final result = await userService.getHistoryHealth(date: date);
      if (result.data!.isNotEmpty) {
        _userBpm = result.data;
      } else {
        _userBpm = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _userBpm = [];
    }
    setOnSearch(false);
  }

  Future<void> getUserWeightHistory({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);

    final selectedDate = date ?? DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    try {
      final result = await userService.getWeightData(date: date);
      if (result.data!.isNotEmpty) {
        _userWeight = result.data;
      } else {
        _userWeight = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _userWeight = [];
    }
    setOnSearch(false);
  }

  Future<void> getUserStepHistory({DateTime? date}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);

    final selectedDate = date ?? DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    try {
      final result = await userService.getStepData(date: date);
      print("step data: ${result.data}");
      if (result.data!.isNotEmpty) {
        _userStep = result.data;
      } else {
        _userStep = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _userStep = [];
    }
    setOnSearch(false);
  }

  void activeTrial() async {
    setOnSearch(true);

    notifyListeners();
    try {
      await userService.activeFreeTrial();

      notifyListeners();
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }
    setOnSearch(false);
  }

  Future<TransactionModel> paymentPremium(String? planType) async {
    setOnSearch(true);
    try {
      final ApiResult<TransactionModel> result =
          await userService.paymentPremium(planType);

      late TransactionModel data;
      if (result.message == 'Success') {
        data = result.data;
      } else {
        debugPrint("Error: ${result.message}");
        data = TransactionModel(
            grossAmount: 0.0,
            transactionId: "",
            paymentType: "",
            bank: "",
            vaNumber: "",
            expireTimeUnix: 0,
            expireTimeStr: "",
            serviceName: "",
            status: 2);
      }

      notifyListeners();

      return data;
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");

      return TransactionModel(
          grossAmount: 0.0,
          transactionId: "",
          paymentType: "",
          bank: "",
          vaNumber: "",
          expireTimeUnix: 0,
          expireTimeStr: "",
          serviceName: "",
          status: 2);
    }
  }

  Future<TransactionModel> verifyPayment(String? transaction_id) async {
    setOnSearch(true);
    try {
      final ApiResult<TransactionModel> result =
          await userService.verifyPayment(transaction_id);

      late TransactionModel data;
      if (result.message == 'Success') {
        data = result.data;
      } else {
        debugPrint("Error: ${result.message}");
        data = TransactionModel(
            grossAmount: 0.0,
            transactionId: "",
            paymentType: "",
            bank: "",
            vaNumber: "",
            expireTimeUnix: 0,
            expireTimeStr: "",
            serviceName: "",
            status: 2);
      }

      notifyListeners();

      return data;
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");

      return TransactionModel(
          grossAmount: 0.0,
          transactionId: "",
          paymentType: "",
          bank: "",
          vaNumber: "",
          expireTimeUnix: 0,
          expireTimeStr: "",
          serviceName: "",
          status: 2);
    }
  }

  // Future<void> getHealthData({DateTime? date}) async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   setOnSearch(true);

  //   try {
  //     final result = await userService.getHealthData(date: date);
  //     print("xxxxxxxxx");
  //     print(result);
  //           print("xxxxxxxxx");

  //     if (result.message == 'Success') {
  //       print("get health data ");
  //       _healthData = result.data;
  //     } else {
  //       _healthData = HealthDataModel(averageBpm: 0, healthData: [], chart: []);
  //     }
  //   } catch (e, stacktrace) {
  //     debugPrint("Error: ${e.toString()}");
  //     debugPrint("Stacktrace: ${stacktrace.toString()}");
  //     _userDrink = [];
  //   }
  //   setOnSearch(false);
  // }

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
  void storeExercise(List<ExerciseModel> exercises) async {
    try {
      await userService.storeExercise(
        exercises);

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

    _searchHistory = history.toSet().toList();

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
