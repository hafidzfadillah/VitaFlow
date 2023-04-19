import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';

class CustomAppBar extends StatelessWidget {
  final int point;
  final int level;
  final void Function() onChatPressed;
  final void Function() onMenuPressed;

  CustomAppBar({
    required this.point,
    required this.level,
    required this.onChatPressed,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffEAE7E7)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              
              children: [
                Icon(Icons.star, color: Colors.yellow[700], size: 24),
                SizedBox(width: 4),
                Text("${point.toString()} point",
                    style: normalText.copyWith(
                      fontWeight: FontWeight.w600
                    )
                ),  
                SizedBox(width: 4),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(width: 4),
                Text("Level ${level.toString()}",
                    style: normalText.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Row(
            children: [
              // image gg_bot
              IconButton(
                icon: Image.asset(
                  "assets/images/gg_bot.png",
                  width: 24,
                  height: 24,
                ),
                onPressed: onChatPressed,
              ),
              IconButton(
                icon: Icon(Icons.menu, size: 24),
                color: Color(0xff333333),
                onPressed: onMenuPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
