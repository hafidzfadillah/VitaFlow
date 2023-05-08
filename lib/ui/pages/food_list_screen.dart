import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/viewmodels/connection/connection.dart';
import 'package:vitaflow/core/viewmodels/food/food_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/FoodItem.dart';
import 'package:vitaflow/ui/widgets/SearchHistoryItem.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/input_costume.dart';
import 'package:vitaflow/ui/widgets/loading/LoadingSingleBox.dart';

class FoodListScreen extends StatefulWidget {
  final String defaultMealType;

  const FoodListScreen({Key? key, required this.defaultMealType})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
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
          IconButton(
            onPressed: () {},
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
        child: FoodListBody(search: search, search2: search2),
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

class FoodListBody extends StatelessWidget {
  const FoodListBody({
    super.key,
    required this.search,
    required this.search2,
  });

  final TextEditingController? search;
  final TextEditingController? search2;
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
                    _FoodSearch(search: search),
                    // Konten untuk tab 'Terakhir dimakan'
                 
                         
                        _TopFoodList(search: search2),
                     
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

class _FoodSearch extends StatelessWidget {
  const _FoodSearch({
    super.key,
    required this.search,
  });

  final TextEditingController? search;

  @override
  Widget build(BuildContext context) {
    return  Consumer<FoodProvider>(
      builder: (context, foodProv, _) {
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    onSubmitted: (value) {
                      FoodProvider.instance(context).search(value);
                    },
                    controller: search,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      prefixIcon: Icon(Icons.search, color: Color(0xffB8B8B8)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                          color: Color(0xffEAE7E7),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                          color: Color(0xffEAE7E7),
                        ),
                      ),
                      hintText: 'Cari makanan terakhir dimakan',
                      contentPadding: EdgeInsets.all(18),
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
        TextFormField(
          controller: search,
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
            contentPadding: EdgeInsets.all(18),
          ),
        ),
        const SizedBox(height: 16),
        if(search!.text.isNotEmpty)
          SingleChildScrollView(
            child:  Column(
                  children: foodProv.foods
                          ?.map((e) => FoodItem(
                                title: e.name,
                                size: int.parse(e.defaultSize),
                                cal: e.calories,
                                unit: e.defaultServing,
                              ))
                          .toList() ??
                      [], // add null check operator and default empty list
                ),
          ),
          
        if(search!.text.isEmpty)
          SingleChildScrollView(
            child:  Column(
                  children: [
                    SearchHistoryItem(title:  'Nasi goreng',)
                  ],
                  
                ),

          )

        
      ],
    );
    
      },
    );
  }
}

class _TopFoodList extends StatelessWidget {
  const _TopFoodList({
    super.key,
    required this.search,
  });

  final TextEditingController? search;

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (context, foodProv, _) {
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    onSubmitted: (value) {
                      FoodProvider.instance(context).search(value);
                    },
                    controller: search,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      prefixIcon: Icon(Icons.search, color: Color(0xffB8B8B8)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                          color: Color(0xffEAE7E7),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(
                          color: Color(0xffEAE7E7),
                        ),
                      ),
                      hintText: 'Cari makanan terakhir dimakan',
                      contentPadding: EdgeInsets.all(18),
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
              onSubmitted: (value) {
                FoodProvider.instance(context).search(value);
              },
              controller: search,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                filled: true,
                prefixIcon: Icon(Icons.search, color: Color(0xffB8B8B8)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(
                    color: Color(0xffEAE7E7),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                  borderSide: BorderSide(
                    color: Color(0xffEAE7E7),
                  ),
                ),
                hintText: 'Cari makanan terakhir dimakan',
                contentPadding: EdgeInsets.all(18),
              ),
            ),
          
            SizedBox(height: 16),
            SingleChildScrollView(
              child: Column(
                children: foodProv.foods
                        ?.map((e) => FoodItem(
                              title: e.name,
                              size: int.parse(e.defaultSize),
                              cal: e.calories,
                              unit: e.defaultServing,
                            ))
                        .toList() ??
                    [], // add null check operator and default empty list
              ),
            )
          ],
        );
      },
    );
  }
}
