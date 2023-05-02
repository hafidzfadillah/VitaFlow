import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
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
              MainTopBar(),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  children: [
                    DateSelector(),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: ChangeNotifierProvider(
                        create: (_) => UserProvider(),
                        child: Consumer<UserProvider>(
                            builder: (context, userProvider, _) {
                          if (userProvider.myNutrition == null &&
                              !userProvider.onSearch) {
                            userProvider.getNutrion();
                            return Center(child: CircularProgressIndicator());
                          }

                          if (userProvider.myNutrition == null &&
                              userProvider.onSearch) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Kalori tersisa",
                                      style: normalText.copyWith(
                                          fontSize: 14,
                                          color: Color(0xff454545))),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text( userProvider.myNutrition?.calorieLeft.toString() ?? "0",
                                          style: normalText.copyWith(
                                              fontSize: 37,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text("kcal",
                                          style: normalText.copyWith(
                                              fontSize: 14)),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              NutritionalBar(
                                carbsPercent:  userProvider.myNutrition?.carbPercentage.toDouble() ?? 0,
                                fatPercent: userProvider.myNutrition?.fatPercentage.toDouble() ?? 0,
                                proteinPercent:  userProvider.myNutrition?.proteinPercentage.toDouble() ?? 0,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              NutritionInfoBox(
                                carbs: userProvider.myNutrition?.carbohydrate ?? 0,
                                protein: userProvider.myNutrition?.protein ?? 0,
                                fat: userProvider.myNutrition?.fat ?? 0,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              CaloriRow(
                                  target: userProvider.myNutrition?.targetCalories ??
                                          0,
                                  asupan: userProvider.myNutrition?.intakeCalories ?? 0,
                                  aktivitas: userProvider.myNutrition?.activityCalories ?? 0,
                                  kaloriTersedia:  userProvider.myNutrition?.calorieLeft ?? 0),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    Row(
                      children: [
                        Text("$point point",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        SizedBox(width: 10),
                        Text(level,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
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
