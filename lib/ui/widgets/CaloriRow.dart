import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class CaloriRow extends StatelessWidget {
  const CaloriRow({
    Key? key,
    required this.target,
    required this.asupan,
    required this.aktivitas,
    required this.kaloriTersedia,
  }) : super(key: key);

  final int target;
  final int asupan;
  final int aktivitas;
  final int kaloriTersedia;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              '$target',
              style: normalText.copyWith(
              fontWeight: FontWeight.w600,
                color: Color(0xff333333),
              ),
            ),
            const Text(
              'Target',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
            ),
          ],
        ),

        Text("-", style: const TextStyle(fontSize: 14),),

        Column(
          children: [
            Text(
              '$asupan',
               style: normalText.copyWith(
                fontWeight: FontWeight.w600,
                color: Color(0xff333333),
              ),
            ),
            const Text(
              'Asupan',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
            ),
          ],

        ),
        Text(
          "+",
          style: const TextStyle(fontSize:14)),
        Column(
          children: [
            Text(
              '$aktivitas',
              
              style: normalText.copyWith(
                fontWeight: FontWeight.w600,
                color: Color(0xff333333),
              ),
            ),
            const Text(
              'Aktivitas',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
              
            ),
          ],

        ),
        Text(
          "=",
          style: const TextStyle(fontSize: 14),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),

          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Text(
                '$kaloriTersedia',
                style: normalText.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                
              ),
              const Text(
                'Tersedia',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                                    color: Colors.white,

                ),
                
              ),
            ],
        
          ),
        ),
        
      ],
    );
  }
}
