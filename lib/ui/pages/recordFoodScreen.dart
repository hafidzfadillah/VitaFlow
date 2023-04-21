import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CalorieBox.dart';
import 'package:vitaflow/ui/widgets/DatePicker.dart';
import 'package:vitaflow/ui/widgets/LogFoodCard.dart';
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
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              DateSelector(),
              SizedBox(
                height: 16,
              ),

              Text(
                'Ringkasan',
                style: normalText.copyWith(
                    fontSize: 16, color: Color(0xff333333) , fontWeight:  FontWeight.w600),
              
              ),

              SizedBox(
                height: 16,
              ),
              Row(
                children: [
             
                    Container(
                      width:  MediaQuery.of(context).size.width * 0.55,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sisa kalori",
                                style: normalText.copyWith(
                                    fontSize: 14,
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "2000",
                                style: normalText.copyWith(
                                    fontSize: 14,
                                    color: Color(0xff333333),
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Konsumsi Kalori",
                              style: normalText.copyWith(
                                  fontSize: 14,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "1500",
                              style: normalText.copyWith(
                                  fontSize: 14,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),

                        Divider(
                          color: Color(0xffEAE7E7),
                          thickness: 1,
                        ),

                        SizedBox(
                          height: 5,
                        ),

                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Akg 25%",
                              style: normalText.copyWith(
                                  fontSize: 14,
                                  color: Color(0xffB4B8BB),
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "2700",
                              style: normalText.copyWith(
                                  fontSize: 14,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                                      
                          
                        ],
                      ),
                    ),
          

                  SizedBox(
                    width: 16,
                  ),

                  Text("asdasd")


                  
                 
                ],
              ),

              SizedBox(
                height: 16,
              ),

              NutrientChart(
                carbsPercentage: 75,
                fatPercentage: 20,
                proteinPercentage: 5,
              ),
              SizedBox(
                height: 16,
              ),

             Text(
                'Log makan',
                style: normalText.copyWith(
                    fontSize: 16,
                    color: Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
              
              SizedBox(
                height: 16,
              ),

              Column(
                children: [
                  LogFoodCard(
                    title : "Makan Pagi",
                    icon:                   'assets/images/icon_breakfast.png',

                  ),
                  LogFoodCard(
                    title : "Makan Siang",
                    icon:                   'assets/images/icon_lunch.png',

                  ),

                  LogFoodCard(
                    title : "Makan Malam",
                    icon:                   'assets/images/icon_dinner.png',

                  ),

                  LogFoodCard(
                    title : "Cemilan ",
                    icon:                   'assets/images/icon_snack.png',

                  ),

                  
                ],
              )
              


            ],
          ),
        ));
  }
}
