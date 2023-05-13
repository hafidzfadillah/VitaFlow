import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HistoryStepCard extends StatelessWidget {
  const HistoryStepCard({
    Key? key,
    required this.title,
    required this.value,
    required this.date,
    required this.unit,
    required this.withTarget,
    this.target = 0,
  }) : super(key: key);

  final int value;
  final String title;
  final String date;
  final bool withTarget;
  final String unit;
  final int target;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xffF6F8FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff333333),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            )),
            Text(
              withTarget ? "$value dari $target $unit" : "$value + $unit" ,
              style: const TextStyle(
                color: Color(0xff333333),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}