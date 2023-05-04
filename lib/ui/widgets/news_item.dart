import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defRadius),
              child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset(
                    'assets/images/news1.png',
                  )),
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tips',
                    style: GoogleFonts.poppins(color: neutral60),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    'Ini dia tips biar kamu bisa push uplorem ipsum dolor sit amet',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: subheaderSize),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    '2 jam baca',
                    style: GoogleFonts.poppins(color: neutral60),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
