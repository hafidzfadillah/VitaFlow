import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../../injection.dart';
import '../../models/exercise/exercise_model.dart';
import '../../services/exercise_service.dart';

class ExerciseProvider with ChangeNotifier {
  ///=========================
  /// Property Sections
  ///=========================

  /// List of exercises
  List<ExerciseModel>? _exercises;
  List<ExerciseModel>? get exercises => _exercises;

  /// Dependency injection
  final exerciseService = locator<ExerciseService>();

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Save latest keyword
  String? _latestKeyword;
  String? get latestKeyword => _latestKeyword;

  /// List of search result exercises
  List<ExerciseModel>? _searchExercises;
  List<ExerciseModel>? get searchExercises => _searchExercises;

  /// List of selected exercises
  List<ExerciseModel> _selectedExercises = [];
  List<ExerciseModel> get selectedExercises => _selectedExercises;

  ///=========================
  /// Function Logic Sections
  ///=========================

  /// Instance provider
  static ExerciseProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<void> getExercises() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await exerciseService.getExercise();

      if (result.message == 'Success') {
        _exercises = result.data;
      } else {
        _exercises = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _exercises = [];
    }
    setOnSearch(false);
  }

  /// Get detail of exercise

  /// Search exercise by keywords
  void search(String keyword) async {
    print('in provider' + keyword);
    _exercises = null;
    if (keyword.isEmpty) {
      _exercises = null;
      setOnSearch(false);
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      setOnSearch(true);
      _latestKeyword = keyword;
      try {
        final result = await exerciseService.searchExercise(keyword);
        print(keyword);
        if (result.message == "Success") {
          print('ok');
          _exercises = result.data;
        } else {
          _exercises = [];
        }
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        _exercises = [];
      }
      setOnSearch(false);
    }
  }

  void searchLastSearch(String keyword) async {
    print('in provider' + keyword);
    _searchExercises = null;
    if (keyword.isEmpty) {
      _searchExercises = null;
      setOnSearch(false);
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      setOnSearch(true);
      _latestKeyword = keyword;
      try {
        final result = await exerciseService.searchExercise(keyword);
        if (result.message == "Success") {
          _searchExercises = result.data;
        } else {
          _searchExercises = [];
        }
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        _exercises = [];
      }
      setOnSearch(false);
    }
  }

  void addSelectedExercise(ExerciseModel exercise, bool isSelected) {
    if (isSelected) {
      if (!selectedExercises.contains(exercise)) {
        selectedExercises.add(exercise);
      }
    } else {
      selectedExercises.remove(exercise);
    }
    notifyListeners();
  }

  /// Clear exercises
  void clearExercises() {
    _exercises = null;
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
