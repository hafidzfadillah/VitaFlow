import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/models/foods/food_lite.dart';
import 'package:vitaflow/core/viewmodels/classify/classify_provider.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
import 'package:vitaflow/core/viewmodels/food/food_provider.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/FoodItem.dart';
import 'package:vitaflow/ui/widgets/SearchHistoryItem.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/input_costume.dart';
import 'package:vitaflow/ui/widgets/loading/LoadingSingleBox.dart';
import 'package:vitaflow/ui/widgets/picker_image.dart';

class FoodListScreen extends StatefulWidget {
  final String defaultMealType;

  const FoodListScreen({Key? key, required this.defaultMealType})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen>
    with TickerProviderStateMixin {
  TextEditingController? search = TextEditingController(text: "");
  TextEditingController? search2 = TextEditingController(text: "");

  late String _mealType; // default meal type
  final List<String> _mealTypes = [
    'Makan Pagi',
    'Makan Siang',
    'Makan Malam',
    'Cemilan'
  ]; // list of meal types
  int _selectedMealTypeIndex = 0;
  @override
  void initState() {
    super.initState();

    _mealType = widget.defaultMealType;
  }

  Map<FoodLiteModel, bool> selectedFoods = {};
  void _updateSelectedFoods(Map<FoodLiteModel, bool> selectedFoods) {
    setState(() {
      this.selectedFoods = selectedFoods;
    });
  }

  // didupdate

  /// Image result from picker image
  File? image;

  /// Pick some pictures
  /// and scan the images
  void choosePicture() async {
    final classifyProv = Provider.of<ClassifyProvider>(context, listen: false);

    /// Take picture just only availble on idle and complete state
    if (classifyProv.scanState == ClassifyState.Idle ||
        classifyProv.scanState == ClassifyState.Complete) {
      await PickerImage.pick(context, (_image) {
        setState(() {
          image = _image;
        });
        classifyProv.scan(context, _image);
      });
    }
  }

  _loadClassiyData() {
    final classiyProv = ClassifyProvider.instance(context);

    FoodProvider.instance(context).clearFoods();
    FoodProvider.instance(context)
        .searchLastSearch(classiyProv.productResult?.substring(2) ?? '');

    if (classiyProv.productResult != null &&
        classiyProv.scanState == ClassifyState.Complete) {
      print('aku diload');
      // Reload the FoodProvider
      FoodProvider.instance(context).getFoods();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      floatingActionButton: selectedFoods.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                List<FoodLiteModel> selected = selectedFoods.entries
                    .where((element) => element.value)
                    .map((e) => e.key)
                    .toList();

                final UserProvider userProvider = UserProvider();

                userProvider.storeFoods(selected, _mealType);
                // delay
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.popAndPushNamed(context, '/food-record');
                });
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.check),
            )
          : const FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.grey,
              child: Icon(Icons.check),
            ),
      appBar: AppBar(
        backgroundColor: lightModeBgColor,
        elevation: 0,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            _showMealTypesDialog(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _mealType,
                style: normalText.copyWith(
                    fontSize: 16,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: 8,
              ),
              Image.asset(
                'assets/images/arrow_down.png',
                width: 14,
                height: 14,
                color: const Color(0xff333333),
              )
            ],
          ),
        ),
        actions: [
          // if selected foods is not empty, show the delete icon button
          if (selectedFoods.isNotEmpty)
            IconButton(
              onPressed: () {
                setState(() {
                  selectedFoods.clear();
                });
              },
              icon: const Icon(Icons.delete, color: Color(0xff333333)),
            ),

          if (selectedFoods.isEmpty)
            IconButton(
              onPressed: () {
                choosePicture();
              },
              icon: const Icon(Icons.more_vert, color: Color(0xff333333)),
            ),
        ],
        leading: CustomBackButton(
          onClick: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => FoodProvider(),
        child: FoodListBody(
          search: search,
          search2: search2,
          selectedFoods: selectedFoods,
          updateSelectedFoods: _updateSelectedFoods,
        ),
      ),
    );
  }

  // Function to show the meal types dialog
  void _showMealTypesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: _mealTypes
                  .asMap()
                  .entries
                  .map(
                    (entry) => GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.value,
                              style: normalText.copyWith(
                                color: _selectedMealTypeIndex == entry.key
                                    ? Colors.green
                                    : const Color(0xff333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            _selectedMealTypeIndex == entry.key
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedMealTypeIndex = entry.key;
                          _mealType = entry.value;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class FoodListBody extends StatefulWidget {
  FoodListBody({
    super.key,
    required this.search,
    required this.search2,
    required this.selectedFoods,
    required this.updateSelectedFoods,
  });

  final TextEditingController? search;
  final TextEditingController? search2;
  Map<FoodLiteModel, bool> selectedFoods = {};
  final Function(Map<FoodLiteModel, bool> selectedFoods) updateSelectedFoods;

  @override
  State<FoodListBody> createState() => _FoodListBodyState();
}

class _FoodListBodyState extends State<FoodListBody> {
  Future<void> refreshHome(BuildContext context) async {
    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(builder: (context, connectionProv, _) {
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
        child: DefaultTabController(
          length: 2, // Jumlah tabs
          child: Column(
            children: [
              const TabBar(
                labelStyle: TextStyle(fontSize: 14, color: Color(0xff333333)),
                labelColor: Color(0xff333333),
                indicatorColor:
                    Colors.green, // Warna indicator untuk tab yang aktif
                tabs: [
                  Tab(text: 'Terakhir dicari'),
                  Tab(text: 'Makanan Populer'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Konten untuk tab 'Makanan yang terakhir dicari'
                    _FoodSearch(
                        search: widget.search,
                        selectedFoods: widget.selectedFoods,
                        updateSelectedFoods: widget.updateSelectedFoods),
                    // Konten untuk tab 'Terakhir dimakan'

                    _TopFoodList(
                        search: widget.search2,
                        selectedFoods: widget.selectedFoods,
                        updateSelectedFoods: widget.updateSelectedFoods),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _FoodSearch extends StatefulWidget {
  const _FoodSearch({
    required this.search,
    required this.selectedFoods,
    required this.updateSelectedFoods,
  });

  final TextEditingController? search;
  final Map<FoodLiteModel, bool> selectedFoods;
  final Function updateSelectedFoods;
  @override
  State<_FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends State<_FoodSearch> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<FoodProvider, UserProvider>(
      builder: (context, foodProv, userProv, _) {
        if (userProv.searchHistory == null && !userProv.onSearch) {
          userProv.loadSearchHistory();

          return Container(
            padding: EdgeInsets.symmetric(horizontal: defMargin),
            margin: const EdgeInsets.only(bottom: 10),
            child: const CircularProgressIndicator(),
          );
        }
        if (userProv.searchHistory == null && userProv.onSearch) {
          // if the categories are being searched, show a skeleton loading
          return Container(
            padding: EdgeInsets.symmetric(horizontal: defMargin),
            margin: const EdgeInsets.only(bottom: 10),
            child: const CircularProgressIndicator(),
          );
        }
        if (userProv.searchHistory.isEmpty) {
          // if the categories have been loaded, show the category chips
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    onSubmitted: (value) {
                      FoodProvider.instance(context).searchLastSearch(value);
                    },
                    controller: widget.search,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xffB8B8B8)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Color(0xffEAE7E7),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: const BorderSide(
                          color: Color(0xffEAE7E7),
                        ),
                      ),
                      hintText: 'Cari makanan terakhir dimakan',
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Text('Tidak ada produk yang ditemukan'),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            TextField(
              controller: widget.search,
              onSubmitted: (value) {
                FoodProvider.instance(context).searchLastSearch(value);
                userProv.searchLastSearch(value);
              },
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                prefixIcon: const Icon(Icons.search, color: Color(0xffB8B8B8)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Color(0xffEAE7E7),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: const BorderSide(
                    color: Color(0xffEAE7E7),
                  ),
                ),
                hintText: 'Makan apa yah',
                contentPadding: const EdgeInsets.all(18),
              ),
            ),
            const SizedBox(height: 16),
            if (foodProv.searchFoods?.isEmpty ?? true)
              SingleChildScrollView(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: userProv.searchHistory.map((e) {
                    return GestureDetector(
                      onTap: () {
                        widget.search!.text = e;
                        FoodProvider.instance(context).searchLastSearch(e);
                      },
                      child: SearchHistoryItem(title: e),
                    );
                  }).toList(),
                ),
              ),
            if (foodProv.searchFoods?.isNotEmpty ?? false)
              SingleChildScrollView(
                child: Column(
                  children: foodProv.searchFoods
                          ?.map((e) => FoodItem(
                                title: e.name,
                                size: int.parse(e.defaultSize),
                                cal: e.calories.toInt(),
                                unit: e.defaultServing,
                                isChecked: widget.selectedFoods[e] ?? false,
                                onSelect: (value) {
                                  setState(() {
                                    widget.selectedFoods[e] = value;
                                    if (!value) {
                                      widget.selectedFoods.remove(e);
                                    }
                                  });
                                  widget.updateSelectedFoods(
                                      widget.selectedFoods);
                                }, // update value isChecked dari parent screen
                              ))
                          .toList() ??
                      [], // add null check operator and default empty list
                ),
              ),
          ],
        );
      },
    );
  }
}

class _TopFoodList extends StatefulWidget {
  const _TopFoodList({
    Key? key,
    required this.search,
    required this.selectedFoods,
    required this.updateSelectedFoods,
  }) : super(key: key);

  final TextEditingController? search;
  final Map<FoodLiteModel, bool> selectedFoods;
  final Function updateSelectedFoods;

  @override
  State<_TopFoodList> createState() => _TopFoodListState();
}

class _TopFoodListState extends State<_TopFoodList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) => Consumer2<FoodProvider, ClassifyProvider>(
              builder: (context, foodProv, classifyProvider, _) {
                if (foodProv.foods == null && !foodProv.onSearch) {
                  foodProv.getFoods();

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: defMargin),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const CircularProgressIndicator(),
                  );
                }
                if (foodProv.foods == null && foodProv.onSearch) {
                  // if the categories are being searched, show a skeleton loading
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: defMargin),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const CircularProgressIndicator(),
                  );
                }
                if (foodProv.foods!.isEmpty) {
                  // if the categories have been loaded, show the category chips
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Center(
                      child: Column(
                        children: [
                          TextField(
                            onSubmitted: (value) {
                              FoodProvider.instance(context).search(value);
                            },
                            controller: widget.search,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              prefixIcon: const Icon(Icons.search,
                                  color: Color(0xffB8B8B8)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: Color(0xffEAE7E7),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: const BorderSide(
                                  color: Color(0xffEAE7E7),
                                ),
                              ),
                              hintText: 'Cari makanan terakhir dimakan',
                              contentPadding: const EdgeInsets.all(18),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child:
                                const Text('Tidak ada produk yang ditemukan'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // di dalam widget
                if (classifyProvider.scanState == ClassifyState.Scanning) {
                  print(classifyProvider.productResult?.substring(2));
                  // FoodProvider.instance(context).search(
                  //     classifyProvider.productResult?.substring(2) ?? "");
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: defMargin),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const CircularProgressIndicator(),
                  );
                }

                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  children: [
                    TextField(
                      onSubmitted: (value) {
                        FoodProvider.instance(context).search(value);
                      },
                      controller: widget.search,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        filled: true,
                        prefixIcon:
                            const Icon(Icons.search, color: Color(0xffB8B8B8)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Color(0xffEAE7E7),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11),
                          borderSide: const BorderSide(
                            color: Color(0xffEAE7E7),
                          ),
                        ),
                        hintText: 'Cari makanan terakhir dimakan',
                        contentPadding: const EdgeInsets.all(18),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      child: Column(
                        children: foodProv.foods
                                ?.map((e) => FoodItem(
                                      title: e.name,
                                      size: int.parse(e.defaultSize),
                                      cal: e.calories.toInt(),
                                      unit: e.defaultServing,
                                      isChecked:
                                          widget.selectedFoods[e] ?? false,
                                      onSelect: (value) {
                                        setState(() {
                                          widget.selectedFoods[e] = value;
                                          if (!value) {
                                            widget.selectedFoods.remove(e);
                                          }
                                        });
                                        widget.updateSelectedFoods(
                                            widget.selectedFoods);
                                      }, // update value isChecked dari parent screen
                                    ))
                                .toList() ??
                            [], // add null check operator and default empty list
                      ),
                    ),
                  ],
                );
              },
            ));
  }
}
