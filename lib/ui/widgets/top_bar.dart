import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';

class MainTopBar extends StatelessWidget {
  const MainTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(defMargin),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: defMargin, vertical: 0.5.h),
              decoration: BoxDecoration(
                  border: Border.all(color: neutral30),
                  borderRadius: BorderRadius.circular(defMargin)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade600,
                  ),
                  SizedBox(
                    width: 1.h,
                  ),
                  Text(
                    '90 poin • Level 1',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/chatbot');
              },
              child: Icon(Icons.smart_toy_outlined)),
          SizedBox(
            width: 2.h,
          ),
          InkWell(onTap: () {}, child: Icon(Icons.menu)),
        ],
      ),
    );
  }
}
