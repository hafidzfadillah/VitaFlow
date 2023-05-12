import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/models/product/product_banner.dart';
import 'package:vitaflow/core/viewmodels/categories/categories_provider.dart';

import '../../../injection.dart';
import '../../models/product/product_model.dart';
import '../../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  /// Property Sections

  /// List of products
  List<ProductModel>? _products;
  List<ProductModel>? get products => _products;

  /// Dependency injection
  final productService = locator<ProductService>();

  /// Property to check mounted before notify
  bool isDisposed = false;

  /// Event handling
  bool _onSearch = false;
  bool get onSearch => _onSearch;

  /// Save latest keyword
  String? _latestKeyword;
  String? get latestKeyword => _latestKeyword;

  /// List of search result restaurants
  List<ProductModel>? _searchProduct;
  List<ProductModel>? get searchProduct => _searchProduct;

  // List of banenr products
  List<ProductBannerModel>? _bannerProducts;
  List<ProductBannerModel>? get bannerProducts => _bannerProducts;

  int _selectedCategory = 0;
  int get selectedCategory => _selectedCategory;




  

  /// Instance provider
  static ProductProvider instance(BuildContext context) =>
      Provider.of(context, listen: false);

  Future<void> getProducts({int? categoryId}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    setOnSearch(true);
    try {
      final result = await productService.getProducts(
        categoryId: selectedCategory,
      );

      print(result.message);

      if (result.message == 'Success') {
        _products = result.data;
      } else {
        _products = [];
      }

      notifyListeners();
    } catch (e, stacktrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("Stacktrace: ${stacktrace.toString()}");
      _products = [];
    }
    setOnSearch(false);
  }

  void search(String keyword) async {
    _searchProduct = null;
    if (keyword.isEmpty) {
      _searchProduct = null;
      setOnSearch(false);
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
      setOnSearch(true);
      _latestKeyword = keyword;
      try {
        final result = await productService.searchProduct(keyword);
        print(keyword);
        if (result.message == "Success") {
          print(result.data);
          _searchProduct = result.data;
        } else {
          _searchProduct = [];
        }
      } catch (e) {
        debugPrint("Error: ${e.toString()}");
        _searchProduct = [];
      }
      setOnSearch(false);
    }
  }

  void setSelectedCategory(int value) {
    _selectedCategory = value;
    _products = null;
    notifyListeners();
  }

  void setOnSearch(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  // clear products
  void clearProducts() {
    _products = null;
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
