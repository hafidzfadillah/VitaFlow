import 'package:flutter/material.dart';
import 'package:vitaflow/ui/widgets/calorie_box.dart';

class NutrientSummary extends StatelessWidget {
  final double calories;
  final double protein;
  final double fat;
  final double carbs;

  const NutrientSummary({
    Key? key,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Calories: ${calories.toStringAsFixed(1)}'),
            Text('Protein: ${protein.toStringAsFixed(1)}g'),
            Text('Fat: ${fat.toStringAsFixed(1)}g'),
            Text('Carbs: ${carbs.toStringAsFixed(1)}g'),
          ],
        ),
        Expanded(
          child: CalorieBox(percentage: calories / 2000),
        ),
      ],
    );
  }
}
