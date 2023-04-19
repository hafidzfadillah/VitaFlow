import  'package:flutter/material.dart' ;
import 'package:flutter/material.dart';

class NutritionalBar extends StatelessWidget {
  final double carbsPercent;
  final double fatPercent;
  final double proteinPercent;

  const NutritionalBar({
    Key? key,
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinPercent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 32,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          _buildNutrientBar(
            color: Color(0xff0BB576),
            widthFactor: carbsPercent,
            radius: 8.0,
            totalWidth: totalWidth,
          ),
          _buildNutrientBar(
            color: Color(0xffF39CFF),
            widthFactor: fatPercent,
            leftOffset: totalWidth * carbsPercent,
            totalWidth: totalWidth,
          ),
          _buildNutrientBar(
            color: Color(0xffFFDD60),
            widthFactor: proteinPercent,
            leftOffset: totalWidth * (carbsPercent + fatPercent),
            totalWidth: totalWidth,
            radius: 8.0,
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientBar({
    required Color color,
    required double widthFactor,
    double leftOffset = 0.0,
    double radius: 0,
    required double totalWidth,
  }) {
    return Positioned(
      left: leftOffset,
      child: Container(
        height: 32,
        width: totalWidth * widthFactor,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(leftOffset == 0 ? radius : 0),
            bottomLeft: Radius.circular(leftOffset == 0 ? radius : 0),
            topRight: Radius.circular(
                leftOffset == totalWidth * (carbsPercent + fatPercent)
                    ? radius
                    : 0),
            bottomRight: Radius.circular(
                leftOffset == totalWidth * (carbsPercent + fatPercent)
                    ? radius
                    : 0),
          ),
        ),
      ),
    );
  }
}
    