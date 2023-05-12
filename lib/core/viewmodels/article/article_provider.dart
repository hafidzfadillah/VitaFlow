import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/models/article/article_model.dart';
import 'package:vitaflow/core/services/article_service.dart';
import 'package:vitaflow/injection.dart';

class ArticleProvider extends ChangeNotifier {
  ///=========================
  /// Property Sections
  ///=========================

  /// List of articles
  List<ArticleModel>? _articles;
  List<ArticleModel>? get articles => _articles;

  /// List of newest articles'
  List<ArticleModel>? _newestArticles;
  List<ArticleModel>? get newestArticles => _newestArticles;

  /// Dependency injection
  final articleService = locator<ArticleService>();

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  ///=========================
  /// Function Logic Sections
  ///=========================

  /// Instance provider
  static ArticleProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

Future<void> getArticles() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await articleService.getArticles();

      if (result.message == 'Success') {
        _articles = result.data;

        // take 3 newest articles
         _newestArticles = _articles!.take(3).toList();

        // remove 3 newest articles from list
        _articles!.removeRange(0, 3);

        // merge newest articles and remaining articles
        _articles = [ ..._articles!];
      } else {
        _articles = [];
      }
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _articles = [];
    }
    setOnSearch(false);
  }


  /// Search articles by keywords

  void clearArticles() {
    _articles = null;
    _newestArticles = null;
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
