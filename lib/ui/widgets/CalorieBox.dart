import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class CalorieBox extends StatelessWidget {
  final double percentage;

  const CalorieBox({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final size = width < height ? width : height;
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: lightModeBgColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 10,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  100,
                  (index) {
                    final cellUsed = index < percentage * 100;
                    return Container(
                      decoration: BoxDecoration(
                        color: cellUsed ? Color(0xff18B279) : Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
