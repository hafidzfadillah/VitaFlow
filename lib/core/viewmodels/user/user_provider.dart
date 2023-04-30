import 'package:flutter/material.dart';
import 'package:vitaflow/core/models/user/user_model.dart';
import 'package:vitaflow/core/services/user_service.dart';
import 'package:vitaflow/injection.dart';

class UserProvider extends ChangeNotifier {
  // Dependency Injection
  final userService = locator<UserService>();

  // Property to check mounted before notify
  bool isDisposed = false;

  // Event handling
  bool _onLogin = false;
  bool get onLogin => _onLogin;

  // User data
  UserModel? _user;
  UserModel? get user => _user;

  // Login function
  Future<bool> login(String email, String password) async {
    setOnLogin(true);
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

  // Set event login
  void setOnLogin(bool value) {
    _onLogin = value;
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
