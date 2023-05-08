import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/core/viewmodels/categories/categories_provider.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
import 'package:vitaflow/core/viewmodels/product/product_provider.dart';
import 'package:vitaflow/dummy/product_banner.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/product_search_screen.dart';
import 'package:vitaflow/ui/widgets/chip_item.dart';
import 'package:vitaflow/ui/widgets/loading/LoadingSingleBox.dart';
import 'package:vitaflow/ui/widgets/loading/LoadingTypeHorizontal.dart';
import 'package:vitaflow/ui/widgets/product_item.dart';

import '../widgets/button.dart';

class VitaMartScreen extends StatelessWidget {
  const VitaMartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => CategoryProvider()),
          ChangeNotifierProvider(create: (create) => ProductProvider())
        ],
        child: const VitaMartBody(),
      ),
    );
  }
}

class VitaMartBody extends StatelessWidget {
  const VitaMartBody({super.key});

  Future<void> refreshHome(BuildContext context) async {
    final productProv = ProductProvider.instance(context);
    final categoryProv = CategoryProvider.instance(context);
    categoryProv.clearCategories();
    productProv.clearProducts();

    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(
      builder: (context, connectionProv, _) {
        if (connectionProv.internetConnected == false) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Tidak Ada Koneksi Internet"),
                ElevatedButton(
                  onPressed: () => refreshHome(context),
                  child: const Text("Refresh"),
                )
              ],
            ),
          );
        }

        return SafeArea(
          child: RefreshIndicator(
              onRefresh: () => refreshHome(context),
              child: Column(children: [
                _appbar(
                  context,
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: defMargin),
                    children: [
                      _buildBanner(),
                      const SizedBox(
                        height: 16,
                      ),
                      _CategoryListWidget(),
                      const SizedBox(
                        height: 16,
                      ),
                      const _ProductListWidget()
                    ],
                  ),
                )
              ])),
        );
      },
    );
  }
}

class _ProductListWidget extends StatelessWidget {
  const _ProductListWidget();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProv, _) {
        if (productProv.products == null && !productProv.onSearch) {
          productProv.getProducts();

          return Container(
            padding: EdgeInsets.symmetric(horizontal: defMargin),
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingSingleBox(),
          );
        }
        if (productProv.products == null && productProv.onSearch) {
          // if the categories are being searched, show a skeleton loading
          return Container(
            padding: EdgeInsets.symmetric(horizontal: defMargin),
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingSingleBox(),
          );
        }
        if (productProv.products!.isEmpty) {
          // if the categories have been loaded, show the category chips
          return Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text('Tidak ada produk yang ditemukan'),
            ),
          );
        }

        return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: productProv.products!.length,
            itemBuilder: (context, index) {
              return ProductItem(product: productProv.products![index]);
            });
      },
    );
  }
}

class _CategoryListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, CategoryProvider>(
      builder: (context, productProv, categoryProv, _) {
        if (categoryProv.categories == null && !categoryProv.onSearch) {
          // get categories provider
          categoryProv.getCategories();
          // if the categories haven't been loaded yet, show a skeleton loading
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingTypeHorizontal(),
          );
        } else if (categoryProv.categories == null && categoryProv.onSearch) {
          // if the categories are being searched, show a skeleton loading
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: const LoadingTypeHorizontal(),
          );
        }
        if (categoryProv.categories!.isEmpty) {
          // if the categories have been loaded, show the category chips
          return Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text('Tidak ada Kategori ditemukan'),
            ),
          );
        }
        final allCategories = [
          'All',
          ...categoryProv.categories!.map((category) => category.name).toList()
        ];

        return GestureDetector(
          onTap: () {
            final productProv = ProductProvider.instance(context);
            productProv.clearProducts();
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: allCategories
                    .map((val) => ChipItem(
                          name: val,
                          isFirst: allCategories.indexOf(val) == 0,
                          isActive: allCategories.indexOf(val) ==
                              productProv.selectedCategory,
                          onClick: () {
                            final productProv =
                                ProductProvider.instance(context);
                            productProv.setSelectedCategory(
                                allCategories.indexOf(val));
                          },
                        ))
                    .toList()),
          ),
        );
      },
    );
  }
}

Widget _appbar(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(defMargin),
    color: Colors.white,
    child: Row(children: [
      Expanded(
          child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductSearchScreen()));
        },
        child: Container(
          padding: EdgeInsets.all(defMargin),
          decoration: BoxDecoration(
              color: const Color(0xffF6F8FA),
              borderRadius: BorderRadius.circular(defRadius)),
          child: Row(
            children: [
              const Icon(Icons.search),
              SizedBox(
                width: 1.h,
              ),
              Text(
                'Cari barang',
                style: GoogleFonts.poppins(),
              )
            ],
          ),
        ),
      )),
      SizedBox(
        width: 1.h,
      ),
      IconButton(
          onPressed: () {}, icon: const Icon(Icons.shopping_bag_outlined)),
      NotifButton(
        hasUnreadNotifications: true,
        onClick: () {},
      )
    ]),
  );
}

Widget _buildBanner() {
  return CarouselSlider.builder(
      itemCount: dummyBannerProducts.length,
      itemBuilder: (context, index, realIndex) {
        return Builder(builder: ((context) {
          final e = dummyBannerProducts[index];
          return InkWell(
            onTap: (() {}),
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defRadius),
                ),
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(defRadius),
                    child: Image.asset(
                      e.background,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: defRadius, top: defRadius, right: 48),
                    child: Text(
                      e.title,
                      softWrap: true,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: subheaderSize),
                    ),
                  ),
                  Positioned(
                      bottom: 6,
                      right: 12,
                      child: Image.asset(
                       e.image,
                        width: 100,
                        height: 100,
                      )),
                  Positioned(
                      bottom: 12,
                      left: 12,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 1.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                           ),
                        child: Text(
                          'Lihat Detail',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ))
                ])),
          );
        }));
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 0.9,
        height: 20.h,
      ));
}
