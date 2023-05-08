import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vitaflow/core/models/foods/food_lite.dart';
import 'package:vitaflow/core/services/food_service.dart';
import 'package:vitaflow/injection.dart';

class FoodProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections
  ///=========================

  /// List of foods
  List<FoodLiteModel>? _foods;
  List<FoodLiteModel>? get foods => _foods;

  /// Dependency injection
  final foodService = locator<FoodService>();

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Save latest keyword
  String? _latestKeyword;
  String? get latestKeyword => _latestKeyword;

  /// List of search result restaurants
  List<FoodLiteModel>? _searchFoods;
  List<FoodLiteModel>? get searchFoods => _searchFoods;

  ///=========================
  /// Function Logic Sections
  ///=========================

  /// Instance provider
  static FoodProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<void> getFoods() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await foodService.getFoods();

      if (result.message == 'Success') {
        _foods = result.data;
      } else {
        _foods = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _foods = [];
    }
    setOnSearch(false);
  }

  /// Get detail of food

  /// Search food by keywords
  ///
  ///
  void search(String keyword) async {
    print('in provider' + keyword);
    _foods = null;
    if (keyword.isEmpty) {
      _foods = null;
      setOnSearch(false);
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      setOnSearch(true);
      _latestKeyword = keyword;
      try {
        final result = await foodService.searchFoods(keyword);
        print(keyword);
        if (result.message == "Success") {
          print('ok');
          _foods = result.data;
        } else {
          _foods = [];
        }
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        _foods = [];
      }
      setOnSearch(false);
    }
  }

  void clearFoods() {
    _foods = null;
    notifyListeners();
  }

  /// Set event search
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
