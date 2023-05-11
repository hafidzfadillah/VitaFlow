import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';

class WeightIndicator extends StatelessWidget {
  final num bmi;
  final String label;

  const WeightIndicator({super.key, required this.bmi, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          LinearProgressIndicator(
            value: (bmi.toDouble() - 18.5) / 11.5,
            minHeight: 1.h,
            backgroundColor: neutral30,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Underweight',
                style: GoogleFonts.poppins(
                    fontSize: captionSize,
                    color: label.toLowerCase().contains('under')
                        ? Colors.amber
                        : Colors.grey),
              ),
              Text(
                'Normal',
                style: GoogleFonts.poppins(
                    fontSize: captionSize,
                    color: label.toLowerCase().contains('normal')
                        ? primaryColor
                        : Colors.grey),
              ),
              Text(
                'Overweight',
                style: GoogleFonts.poppins(
                    fontSize: captionSize,
                    color: label.toLowerCase().contains('over')
                        ? Colors.amber
                        : Colors.grey),
              ),
              Text(
                'Obesity',
                style: GoogleFonts.poppins(
                    fontSize: captionSize,
                    color: label.toLowerCase().contains('obe')
                        ? Colors.red
                        : Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
