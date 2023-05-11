import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/models/message/message_model.dart';

import 'package:vitaflow/core/services/categories_service.dart';
import 'package:vitaflow/core/services/chat_service.dart';
import 'package:vitaflow/injection.dart';

class ChatProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections
  ///=========================

  /// List of restaurants
  List<MessageModel>? _messages = [];
  List<MessageModel>? get messages => _messages;

  /// Dependency injection
  final chatService = locator<ChatService>();

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  ///=========================
  /// Function Logic Sections
  ///=========================

  /// Instance provider
  static ChatProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  // Login function
  void sendMessage(String message) async {
    setOnSearch(true);
    try {
      _messages?.add(
        MessageModel(
          role: "user",
          message: message,
        ),
      );
      
      _messages?.add(
        MessageModel(
          role: "loading",
          message: 'Vitabot sedang mengetik.....',
        ),
      );
      
      final result = await chatService.sendMessage(message);

      if (result.message == 'Success') {
        
       

        _messages?.add(result.data);
        setOnSearch(false);



      } else {
        _messages?.add(
          MessageModel(
            role: "bot",
            message: "Sorry, sepertinya ada masalah dengan server kami. Silahkan coba lagi nanti . ",
          ),
        );
        setOnSearch(false);

      }
    } catch (e, stacktrace) {
      setOnSearch(false);

      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
    }

    setOnSearch(false);
    _messages?.removeWhere((message) => message.role == "loading");
      
    notifyListeners();
  }

  //LOAD MESSAGE

  /// Get detail of restaurant

  /// Search restaurant by keywords

  /// Finding list of city from local assets

  void clearCategories() {
    _messages = null;
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
