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
          message: 'Mengetik.....',
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
            message:
                "Maaf, Vitabot saat ini belum bisa menjawab pertanyaan Anda",
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

  void setReminderDone(String msg) {
    setOnSearch(true);
    _messages?.add(
      MessageModel(
        role: "user",
        message: msg,
      ),
    );

    _messages?.add(
      MessageModel(
        role: "bot",
        message: 'Pengingat berhasil diset',
      ),
    );
    setOnSearch(false);
    notifyListeners();
  }

  Future<void> showMealPlan(String msg) async {
    setOnSearch(true);
    _messages?.add(
      MessageModel(
        role: "user",
        message: msg,
      ),
    );

    _messages?.add(
      MessageModel(
        role: "loading",
        message: 'Mengetik.....',
      ),
    );
    await Future.delayed(Duration(seconds: 3));

    String mealString = "";
    mealPlan.forEach((meal) {
      mealString += "${meal["title"]}\n";
      meal["meals"].forEach((submeal) {
        mealString += "- ${submeal["name"]} (${submeal["qty"]})\n";
      });
      mealString += "\n";
    });

    mealString +=
        "\nBahan-bahan yang diperlukan dapat Anda temukan di VitaMart";

    _messages?.add(
      MessageModel(
        role: "bot",
        message: mealString,
      ),
    );

    setOnSearch(false);
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

  List<Map<String, dynamic>> mealPlan = [
    {
      "title": "Sarapan",
      "meals": [
        {"name": "Telur Rebus", "qty": "2 butir"},
        {"name": "Pisang", "qty": "1 buah"},
        {"name": "Roti Gandum Panggang", "qty": "1 potong"},
        {"name": "Susu rendah lemak", "qty": "1 gelas"}
      ]
    },
    {
      "title": "Snack Pagi",
      "meals": [
        {"name": "Apel", "qty": "1 buah"},
        {"name": "Kacang Almond", "qty": "1 genggam"}
      ]
    },
    {
      "title": "Makanan Siang",
      "meals": [
        {"name": "Nasi Merah", "qty": "1 porsi"},
        {"name": "Ayam Panggang", "qty": "1 potong"},
        {"name": "Sup Sayuran", "qty": "1 mangkuk"},
        {"name": "Air putih", "qty": "1 gelas"}
      ]
    },
    {
      "title": "Snack Sore",
      "meals": [
        {"name": "Jeruk", "qty": "1 buah"},
        {"name": "Keju Cheddar", "qty": "1 potong"}
      ]
    },
    {
      "title": "Makan Malam",
      "meals": [
        {"name": "Salmon Panggang", "qty": "1 porsi"},
        {"name": "Quinoa", "qty": "1 mangkuk"},
        {"name": "Sayuran Hijau", "qty": "1 mangkuk"},
        {"name": "Air putih", "qty": "1 gelas"}
      ]
    },
    {
      "title": "Snack Malam",
      "meals": [
        {"name": "Yoghurt Rendah Lemak", "qty": "1 cangkir"},
        {"name": "Biji Labu", "qty": "1 sendok makan"}
      ]
    }
  ];
}
