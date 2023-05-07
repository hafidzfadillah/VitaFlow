import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class ChipItem extends StatelessWidget {
  final String name;
  final bool isFirst;
  final double leftMargin;
  final bool isActive;
  final VoidCallback onClick;

  const ChipItem({
    Key? key,
    required this.name,
    required this.isFirst,
    this.leftMargin = 40,
    this.isActive = false,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isActive ? primaryColor : Colors.white;
    final textColor = isActive ? Colors.white : blackColor;

    return Container(
      margin: EdgeInsets.only(
        right: 10,
        top: 10,
        bottom: 10,
        left: isFirst ? 10 : 0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onClick(),
          borderRadius: BorderRadius.circular(5),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Text(
              name,
              style: normalText.copyWith(
                color: textColor,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
