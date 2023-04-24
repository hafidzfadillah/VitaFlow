import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';
import 'package:vitaflow/ui/pages/survey/surveyScreen.dart';

import '../../home/theme.dart';

class Survey4 extends StatefulWidget {
  const Survey4({Key? key}) : super(key: key);

  @override
  State<Survey4> createState() => _Survey4State();
}

class _Survey4State extends State<Survey4> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<Survey>(context);

    return
        Column(children: [
          Text(
            'Pertanyaan 4',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            'Berapa tinggi Anda sekarang?',
            textAlign: TextAlign.center,
              style: surveyHeading,
          ),
          SizedBox(
            height: 4.h,
          ),
          FlutterToggleTab(
              width: 20.w,
              isScroll: false,
              unSelectedBackgroundColors: [
                Color(0xffF6F8FA),
              ],
              labels: ['Centimeter', 'Feet'],
              selectedBackgroundColors: [Colors.white],
              selectedLabelIndex: ((p0) {
                setState(() {
                  _selected = p0;
                });
                if (_selected == 0) {
                  setState(() {
                    survey.heightFormat = HeightFormat.cm;
                  });
                } else {
                  setState(() {
                    survey.heightFormat = HeightFormat.ft;
                  });
                }
              }),
              selectedTextStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, color: Colors.black),
              unSelectedTextStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, color: neutral70),
              selectedIndex: _selected),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20.h,
                child: TextFormField(
                  initialValue: survey.tinggi.toString(),
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: survey.heightFormat == HeightFormat.cm
                        ? "Tinggi (cm)"
                        : "Tinggi (ft)",
                  ),
                  onChanged: (value) {
                    setState(() {
                      survey.tinggi = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 2.h,
              ),
              Text(survey.heightFormat == HeightFormat.cm ? 'cm' : 'ft',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              
            ],
          )
        ]);
  }
}
