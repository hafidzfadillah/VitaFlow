import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/FoodItem.dart';
import 'package:vitaflow/ui/widgets/SearchHistoryItem.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/input_costume.dart';

class FoodListScreen extends StatefulWidget {
  final String defaultMealType;

  const FoodListScreen({Key? key, required this.defaultMealType})
      : super(key: key);

  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  TextEditingController? search = TextEditingController(text: "");

  late String _mealType; // default meal type
  final List<String> _mealTypes = [
    'Makan Pagi',
    'Makan Siang',
    'Makan Malam',
    'Cemilan'
  ]; // list of meal types
  int _selectedMealTypeIndex = 0;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Terakhir dicari'),
    Tab(text: 'Terakhir dimakan'),
  ];
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
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 8,
              ),
              Image.asset(
                'assets/images/arrow_down.png',
                width: 14,
                height: 14,
                color: Color(0xff333333),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Color(0xff333333)),
          ),
        ],
        leading: CustomBackButton(
          onClick: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2, // Jumlah tabs
          child: Column(
            children: [
              TabBar(
                labelStyle: TextStyle(fontSize: 14, color: Color(0xff333333)),
                labelColor: Color(0xff333333),
                indicatorColor:
                    Colors.green, // Warna indicator untuk tab yang aktif
                tabs: [
                  Tab(text: 'Terakhir dicari'),
                  Tab(text: 'Terakhir dimakan'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Konten untuk tab 'Makanan yang terakhir dicari'
                    ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      children: [
                        TextFormField(
                          controller: search,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            prefixIcon:
                                Icon(Icons.search, color: Color(0xffB8B8B8)),
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
                            hintText: 'Makan apa yah',
                            contentPadding: EdgeInsets.all(18),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 16),
                              SearchHistoryItem(
                                title : "Ayam goreng"
                              ),
                                SearchHistoryItem(title: "Ayam sayur"),
                                SearchHistoryItem(title: "Ayam bakar"),
                                SearchHistoryItem(title: "Ayam goreng"),
                                
                            ],
                          ),
                        )
                      ],
                    ),
                    // Konten untuk tab 'Terakhir dimakan'
                    ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      children: [
                        TextFormField(
                          controller: search,
                          decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            prefixIcon:
                                Icon(Icons.search, color: Color(0xffB8B8B8)),
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
                            children: [
                              FoodItem(
                                title: 'Nasi Goreng',
                                unit : "1 porsi",
                                cal: 300,
                                akg : 10
                                
                              ),
                              FoodItem(
                                title: 'Indomie Goreng',
                                unit : "1 Bungkus",
                                cal: 500,
                                akg : 15
                                
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.value,
                              style: normalText.copyWith(
                                color: _selectedMealTypeIndex == entry.key
                                    ? Colors.green
                                    : Color(0xff333333),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            _selectedMealTypeIndex == entry.key
                                ? Icon(
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
