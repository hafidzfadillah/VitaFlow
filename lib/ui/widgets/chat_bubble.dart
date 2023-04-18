import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';

class CustomChatBubble extends StatelessWidget {
  final String text, date;
  final Color background;
  final bool isSender;

  const CustomChatBubble(
      {super.key,
      required this.text,
      required this.date,
      required this.background,
      required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BubbleSpecialOne(
            color: background,
            text: text,
            isSender: isSender,
          ),
          SizedBox(
            height: 4,
          ),
          Padding(
            padding: isSender
                ? EdgeInsets.only(right: defMargin)
                : EdgeInsets.only(left: defMargin),
            child: Text(date,
                style: GoogleFonts.poppins(
                    fontSize: captionSize, color: neutral70)),
          )
        ],
      ),
    );
  }
}
