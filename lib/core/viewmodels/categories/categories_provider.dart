import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vitaflow/core/models/category/category_model.dart';
import 'package:vitaflow/core/services/categories_service.dart';
import 'package:vitaflow/injection.dart';

class CategoryProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections
  ///=========================

  /// List of restaurants
  List<CategoryModel>? _categories;
  List<CategoryModel>? get categories => _categories;

  /// Dependency injection
  final categoryService = locator<CategoryService>();

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  ///=========================
  /// Function Logic Sections
  ///=========================

  /// Instance provider
  static CategoryProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  /// Finding list of restaurant from API
  Future<void> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await categoryService.getRestaurants();

      print('trigger');

      print(' from $result');

      if (result.status == 'success') {
        _categories = result.data;
      } else {
        _categories = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _categories = [];
    }
    setOnSearch(false);
  }

  /// Get detail of restaurant

  /// Search restaurant by keywords

  /// Finding list of city from local assets

  void clearCategories() {
    _categories = null;
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
