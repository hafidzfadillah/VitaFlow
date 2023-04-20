import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CaloriRow.dart';
import 'package:vitaflow/ui/widgets/DatePicker.dart';
import 'package:vitaflow/ui/widgets/Mission.dart';
import 'package:vitaflow/ui/widgets/NutrionInfoBox.dart';
import 'package:vitaflow/ui/widgets/NutritionBar.dart';
import 'package:vitaflow/ui/widgets/top_bar.dart';

import '../widgets/CustomAppBar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,

        //   leading: Row(
        //     children: [
        //       Text("90 point",
        //           style: TextStyle(fontSize: 16, color: Colors.black)),
        //       SizedBox(width: 10), // Menambahkan jarak antara dua text
        //       Text("Level 1",
        //           style: TextStyle(fontSize: 16, color: Colors.black)),
        //     ],
        //   ),
        // ),
        body: SafeArea(
          child: Column(
            children: [
              MainTopBar(),
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
                            Text("1,500",
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
                    Mission(finishMisison: 0, totalMission: 6)
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
