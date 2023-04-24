import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';

class SportItem extends StatelessWidget {
  final String title, imgAddress;
  final int durasi;
  final Function() onClick;

  const SportItem(
      {super.key,
      required this.title,
      required this.durasi,
      required this.imgAddress,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.asset(
                imgAddress,
                height: 20.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(defRadius),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: subheaderSize, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    '$durasi detik',
                    style: GoogleFonts.poppins(
                        fontSize: bodySize, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
