import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/calorie_box.dart';
import 'package:vitaflow/ui/widgets/DatePicker.dart';
import 'package:vitaflow/ui/widgets/log_food_card.dart';
import 'package:vitaflow/ui/widgets/NutrientChart.dart';
import 'package:vitaflow/ui/widgets/NutrionSummary.dart';
import 'package:vitaflow/ui/widgets/button.dart';

import 'package:vitaflow/ui/widgets/top_bar.dart';

import '../widgets/CustomAppBar.dart';

class RecordFoodScreen extends StatelessWidget {
  const RecordFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        appBar: CustomAppBar(
          title: 'Record Makanan',
          backgroundColor: lightModeBgColor,
          elevation: 0,
          leading: CustomBackButton(onClick: () {
            Navigator.pop(context);
          }),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              // DateSelector(),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Ringkasan',
                style: normalText.copyWith(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              ChangeNotifierProvider(
                create: (_) => UserProvider(),
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, _) {
                    if (userProvider.myNutrition == null &&
                        !userProvider.onSearch) {
                      userProvider.getNutrion();
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (userProvider.myNutrition == null &&
                        userProvider.onSearch) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Sisa kalori",
                                        style: normalText.copyWith(
                                            fontSize: 14,
                                            color: const Color(0xff333333),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        userProvider.myNutrition?.calorieLeft
                                                .toString() ??
                                            "0",
                                        style: normalText.copyWith(
                                            fontSize: 14,
                                            color: const Color(0xff333333),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Konsumsi Kalori",
                                        style: normalText.copyWith(
                                            fontSize: 14,
                                            color: const Color(0xff333333),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        userProvider.myNutrition?.intakeCalories
                                                .toString() ??
                                            "0",
                                        style: normalText.copyWith(
                                            fontSize: 14,
                                            color: const Color(0xff333333),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    color: Color(0xffEAE7E7),
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Akg ${userProvider.myNutrition?.akg.toString() ?? "0"}%",
                                        style: normalText.copyWith(
                                            fontSize: 14,
                                            color: const Color(0xffB4B8BB),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        userProvider.myNutrition?.targetCalories
                                                .toString() ??
                                            "0",
                                        style: normalText.copyWith(
                                            fontSize: 14,
                                            color: const Color(0xff333333),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            CalorieBox(
                                percentage:
                                    (userProvider.myNutrition?.akg.toDouble() ??
                                            0) /
                                        100),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        NutrientChart(
                          carbsPercentage: (userProvider
                                      .myNutrition?.carbPercentage
                                      .toDouble() ??
                                  0) *
                              100,
                          fatPercentage: (userProvider
                                      .myNutrition?.fatPercentage
                                      .toDouble() ??
                                  0) *
                              100,
                          proteinPercentage: (userProvider
                                      .myNutrition?.proteinPercentage
                                      .toDouble() ??
                                  0) *
                              100,
                        ),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 16,
              ),
              Text(
                'Log makan',
                style: normalText.copyWith(
                    fontSize: 16,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                children: const [
                  LogFoodCard(
                    title: "Makan Pagi",
                    icon: 'assets/images/icon_breakfast.png',
                  ),
                  LogFoodCard(
                    title: "Makan Siang",
                    icon: 'assets/images/icon_lunch.png',
                  ),
                  LogFoodCard(
                    title: "Makan Malam",
                    icon: 'assets/images/icon_dinner.png',
                  ),
                  LogFoodCard(
                    title: "Cemilan ",
                    icon: 'assets/images/icon_snack.png',
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
