import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/FoodListScreen.dart';

class LogFoodCard extends StatelessWidget {
  const LogFoodCard({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String icon;

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
        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 16),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xffF6F8FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Row(
                children: [
                  Image.asset(
                    icon,
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(title,
                      style: normalText.copyWith(
                          fontSize: 14, color: Color(0xff333333))),
                ],
              ),
            ),
            Icon(Icons.add, size: 24, color: primaryColor)
          ],
        ),
      ),
    );
  }
}
