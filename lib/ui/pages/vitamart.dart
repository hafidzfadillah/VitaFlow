import 'package:carousel_slider/carousel_slider.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/product_item.dart';

import '../widgets/button.dart';

class VitaMart extends StatefulWidget {
  const VitaMart({Key? key}) : super(key: key);

  @override
  State<VitaMart> createState() => _VitaMartState();
}

class _VitaMartState extends State<VitaMart> {
  int _currentCategory = 0;

  final List<String> _dogeNames = [
    'All',
    'Alat Kesehatan',
    'Whey',
    'Alat Gym',
    'Vitamin',
    'Protein'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: SafeArea(
          child: Column(
        children: [
          _appbar(),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(vertical: defMargin),
            children: [
              _buildBanner(),
              SizedBox(height: 2.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ChipList(
                  listOfChipNames: _dogeNames,
                  activeBgColorList: [primaryColor],
                  inactiveBgColorList: [Colors.white],
                  activeTextColorList: [Colors.white],
                  inactiveTextColorList: [neutral70],
                  listOfChipIndicesCurrentlySeclected: [0],
                  scrollPhysics: BouncingScrollPhysics(),
                ),
              ),
              _buildProduct()
            ],
          ))
        ],
      )),
    );
  }

  Widget _appbar() {
    return Container(
      padding: EdgeInsets.all(defMargin),
      color: Colors.white,
      child: Row(children: [
        Expanded(
            child: Container(
          padding: EdgeInsets.all(defMargin),
          decoration: BoxDecoration(
              color: Color(0xffF6F8FA),
              borderRadius: BorderRadius.circular(defRadius)),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 1.h,
              ),
              Text(
                'Cari barang',
                style: GoogleFonts.poppins(),
              )
            ],
          ),
        )),
        SizedBox(
          width: 1.h,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_outlined)),
        NotifButton(
          hasUnreadNotifications: true,
          onClick: () {},
        )
      ]),
    );
  }

  Widget _buildBanner() {
    return CarouselSlider(
        items: [1, 2, 3].map((e) {
          return Builder(builder: ((context) {
            return InkWell(
              onTap: (() {}),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defRadius),
                  ),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(defRadius),
                      child: Image.asset(
                        'assets/images/bg_bmart1.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: defRadius, top: defRadius, right: 48),
                      child: Text(
                        'Dapatkan diskon ${e}0% untuk pembelian Vita Whey',
                        softWrap: true,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: headerSize),
                      ),
                    ),
                    Positioned(
                        bottom: 6,
                        right: 12,
                        child: Image.asset(
                          'assets/images/whey.png',
                          width: 100,
                          height: 100,
                        )),
                    Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.h, vertical: 1.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Color(0xFF13C281))),
                          child: Text(
                            'Lihat Detail',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ))
                  ])),
            );
          }));
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 0.9,
          height: 20.h,
        ));
  }

  Widget _buildProduct() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (c, i) {
        return ProductItem();
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 2.h,
      ),
    );
  }
}
