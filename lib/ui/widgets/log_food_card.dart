import 'package:flutter/material.dart';
import 'package:vitaflow/core/models/user/user_food.dart';
import 'package:vitaflow/ui/home/theme.dart';

import '../pages/food_list_screen.dart';

class LogFoodCard extends StatelessWidget {
  const LogFoodCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.foods,
  }) : super(key: key);

  final String title;
  final String icon;
  final List<UserFood> foods;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String mealTitle = title;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodListScreen(defaultMealType: mealTitle),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 16),
        margin:  const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xffF6F8FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
       
          children: [
            Container(
              padding: foods.isNotEmpty ?   const EdgeInsets.only(bottom: 10) : const EdgeInsets.only(bottom: 0),
              decoration:  BoxDecoration(
                border: foods.isNotEmpty ?   const Border(
                  bottom:  BorderSide(width: 1.0, color: Color(0xffE5E5E5)),
                ) : const Border(

                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        icon,
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(title,
                          style: normalText.copyWith(
                              fontSize: 14, color: const Color(0xff333333))),
                    ],
                  ),
                  


                  Row(
                    children: [
                        if(foods.isNotEmpty)
                          Image.asset('assets/images/cal_icon.png', width: 18, height: 18, fit: BoxFit.cover),
                         
                        if(foods.isNotEmpty)
                           Text(
                          " ${foods.fold<int>(0, (prev, food) => prev + food.calorieIntake)} kalori",
                          style: normalText.copyWith(
                              fontSize: 14,
                              color: const Color(0xff333333),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      const Icon(Icons.add, size: 24, color: primaryColor)


                    ],
                  )

                    
                ],
              ),
            ),
          
            
          Column(
              children: [
                  if (foods.isNotEmpty)
                  SizedBox(height: 16,),

                if (foods.isNotEmpty)
                  for (var i = 0; i < foods.length; i++)
                    
                  
                    _FoodList(food: foods[i]),
                
              ]
            )

          ],
        ),
      ),
    );
  }
}

class _FoodList extends StatelessWidget {
  const _FoodList({
    super.key,
    required this.food
  });

  final UserFood food;

  @override
  
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom:   BorderSide(width: 1.0, color: Color(0xffE5E5E5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(food.foodName,
                  style: normalText.copyWith(
                    fontSize: 14,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(
                height: 5,
              ),

              Text(
                "${food.size} ${food.unit}",
                style: normalText.copyWith(
                  fontSize: 13,
                  color: const Color(0xffB4B8BB),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Expanded(
              child: Text(
            "${food.calorieIntake} kalori",
            textAlign: TextAlign.right,
            style: normalText.copyWith(
              fontSize: 14,
              color: const Color(0xff333333),
              fontWeight: FontWeight.w600,
            ),
          )),
        ],
      ),
    );
  }
}
