import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/news_item.dart';
import 'package:vitaflow/ui/widgets/top_bar.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          MainTopBar(),
          Expanded(
              child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(defMargin),
                child: Text(
                  'Vita Insight',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: headerSize),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              _buildBanner(),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.all(defMargin),
                child: Text(
                  'Artikel Minggu Ini',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: headerSize),
                ),
              ),
              _buildNews()
            ],
          ))
        ],
      )),
    );
  }

  Widget _buildBanner() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 20.h,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defRadius),
                    color: Colors.amber),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(defRadius),
                      child: Image.asset(
                        'assets/images/banner1.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                    Positioned(
                        child: Container(
                      margin: EdgeInsets.all(1.5.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.h, vertical: 0.5.h),
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(defMargin)),
                      child: Text(
                        'Category $i',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: captionSize),
                      ),
                    )),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 10.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(defRadius),
                                bottomRight: Radius.circular(defRadius)),
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black87,
                                  Colors.black54,
                                  Colors.black12,
                                  Colors.transparent
                                ])),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.all(1.5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '2 jam yang lalu',
                              style: GoogleFonts.poppins(
                                  fontSize: captionSize, color: Colors.white),
                            ),
                            Text(
                              'Begini cara tetap bugar saat puasa',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          },
        );
      }).toList(),
    );
  }

  Widget _buildNews() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (c, i) {
          return NewsItem();
        });
  }
}
