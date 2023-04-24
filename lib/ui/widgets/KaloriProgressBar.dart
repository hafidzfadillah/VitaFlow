import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../home/theme.dart';

class KaloriProgressBar extends StatefulWidget {
  final int currentCalories;
  final int goalCalories;
  final double width;

  const KaloriProgressBar(
      {super.key,
      required this.currentCalories,
      required this.goalCalories,
      required this.width});

  @override
  State<KaloriProgressBar> createState() => _KaloriProgressBarState();
}

class _KaloriProgressBarState extends State<KaloriProgressBar> {
  @override
  Widget build(BuildContext context) {
    double percentage = widget.currentCalories / widget.goalCalories;
    double degrees = percentage * 360;

    return SizedBox(
      width: widget.width,
      height: widget.width,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: widget.width,
              height: widget.width,
              child: CircularProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                strokeWidth: 10,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "150",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Kalori terbakar",
                  style: TextStyle(
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
