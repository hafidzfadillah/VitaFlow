import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/button.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: defMargin),
          decoration: BoxDecoration(
              color: Color(0xffF6F8FA),
              borderRadius: BorderRadius.circular(defMargin)),
          padding: EdgeInsets.all(defRadius),
          child: Stack(
            children: [
              Row(
                children: [
                  Flexible(
                      flex: 2,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          'assets/images/whey.png',
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Whey',
                            style: subtitleTextStyle2,
                          ),
                          Text(
                            'Vita Whey Protein',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: subheaderSize),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            'cocok untuk kamu yang lagi bulking',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: subtitleTextStyle2,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'Rp 290.000',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: subheaderSize),
                              ),
                              Spacer(),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  'Beli',
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24))),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              )
            ],
          )),
    );
  }
}
