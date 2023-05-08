import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/viewmodels/categories/categories_provider.dart';
import 'package:vitaflow/core/viewmodels/product/product_provider.dart';
import 'package:vitaflow/navigation/navigation_utils.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/loading/LoadingSingleBox.dart';
import 'package:vitaflow/ui/widgets/product_item.dart';
import 'package:vitaflow/ui/widgets/search_item.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const ProductInitSearchScreen(),
    );
  }
}

class ProductInitSearchScreen extends StatefulWidget {
  const ProductInitSearchScreen({super.key});

  @override
  State<ProductInitSearchScreen> createState() =>
      _ProductInitSearchScreenState();
}

class _ProductInitSearchScreenState extends State<ProductInitSearchScreen> {
  @override
  var searchController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: _searchWidget(),
        leading: IconButton(
          onPressed: () =>  Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: ProductSearchBody(),
    );
  }

  Widget _searchWidget() {
    return SearchItem(
      controller: searchController,
      autoFocus: true,
            onSubmit: (value) => ProductProvider.instance(context).search(value),

    );
  }
}

class ProductSearchBody extends StatelessWidget {
  const ProductSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, productProv, _) {
      if (productProv.searchProduct == null && !productProv.onSearch) {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Search your product'),
          ),
        );
      }

      if (productProv.searchProduct == null && productProv.onSearch) {
        return const LoadingSingleBox();
      }

      if (productProv.searchProduct!.isEmpty) {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text('Product not found'),
          ),
        );
      }

      return ListView.builder(
        itemCount: productProv.searchProduct!.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: productProv.searchProduct![index],
          );
        },
      );
    });
  }
}
