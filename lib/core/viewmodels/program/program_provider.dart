import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/services/program_service.dart';
import 'package:vitaflow/injection.dart';

import '../../models/program/program_model.dart';

class ProgramProvider with ChangeNotifier {
  /// List of programs
  List<ProgramModel>? _programs;
  List<ProgramModel>? get programs => _programs;

  final programService = locator<ProgramService>();

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  static ProgramProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<void> getPrograms() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);

    try{
      final result = await programService.getPrograms();
      print(result.data);

      if(result.data != null) {
        _programs = result.data;
      } else {
        _programs = [];
      }

      notifyListeners();
    } catch(e, stacktrace){
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _programs = [];
    }
    setOnSearch(false);
  }

  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  // clear products
  void clearProducts() {
    _programs = null;
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
