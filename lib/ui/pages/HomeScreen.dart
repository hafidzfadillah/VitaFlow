import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CaloriRow.dart';
import 'package:vitaflow/ui/widgets/DatePicker.dart';
import 'package:vitaflow/ui/widgets/Mission.dart';
import 'package:vitaflow/ui/widgets/NutrionInfoBox.dart';
import 'package:vitaflow/ui/widgets/NutritionBar.dart';
import 'package:vitaflow/ui/widgets/top_bar.dart';

import '../widgets/CustomAppBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int point = 0;
  String level = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      point = prefs.getInt('point') ?? 0;
      level = prefs.getString('level') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        body: SafeArea(
          child: Column(
            children: [
              MainTopBar(
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  children: [
                    DateSelector(),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kalori tersisa",
                            style: normalText.copyWith(
                                fontSize: 14, color: Color(0xff454545))),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(point.toString(),
                                style: normalText.copyWith(
                                    fontSize: 37, fontWeight: FontWeight.w600)),
                            SizedBox(
                              width: 8,
                            ),
                            Text("kcal",
                                style: normalText.copyWith(fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    NutritionalBar(
                      carbsPercent: 0.5,
                      fatPercent: 0.25,
                      proteinPercent: 0.25,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    NutritionInfoBox(
                      carbs: 10,
                      protein: 20,
                      fat: 30,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CaloriRow(
                        target: 2700,
                        asupan: 0,
                        aktivitas: 130,
                        kaloriTersedia: 2600),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Text("$point point",
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                        SizedBox(width: 10),
                        Text(level,
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Mission(finishMisison: 0, totalMission: 6)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

