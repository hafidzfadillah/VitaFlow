import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class NutrionRow extends StatelessWidget {
  const NutrionRow({
    Key? key,
    required this.nutrionName,
    required this.nutrionValue,
    required this.nutrionColor,
    this.isLastItem = false,
  }) : super(key: key);

  final String nutrionName;
  final int nutrionValue;
  final int nutrionColor;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isLastItem   ? EdgeInsets.only(bottom: 0) : EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom:  isLastItem  ? BorderSide(
            color: Colors.transparent,
          ) : BorderSide(
            color: Color(0xFFEAE7E7),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(children: [
              Container(
                height: 18,
                width: 7,
                decoration: BoxDecoration(
                  color: Color(nutrionColor),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                nutrionName,
                style: normalText.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ]),
          ),
          Text(
            nutrionValue.toString() + 'gr',
            style:
                normalText.copyWith(fontSize: 14, fontWeight: FontWeight.w700),
          ),

          
        ],
      ),
    );
  }
}
