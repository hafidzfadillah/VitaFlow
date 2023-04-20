import 'package:flutter/material.dart';

// dart math
import 'dart:math' as math;

import 'package:vitaflow/ui/home/theme.dart';
class DrinkProgressBar extends StatefulWidget {
  final int currentDrink;
  final int goalDrink;
  final double width;

  const DrinkProgressBar({
    Key? key,
    required this.currentDrink,
    required this.goalDrink,
    required this.width,
  }) : super(key: key);

  @override
  _DrinkProgressBarState createState() => _DrinkProgressBarState();
}

class _DrinkProgressBarState extends State<DrinkProgressBar> {
  @override
  Widget build(BuildContext context) {
    double percentage = widget.currentDrink / widget.goalDrink;
    double degrees = percentage * 360;

    return SizedBox(
      width: widget.width,
      height: widget.width,
      child: Stack(
        children: [
          SizedBox(
            width: widget.width,
            height: widget.width,
            child: CircularProgressIndicator(
              value: percentage,
              strokeWidth: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor)
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.currentDrink} / ${widget.goalDrink} ",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Gelas",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff333333),
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
