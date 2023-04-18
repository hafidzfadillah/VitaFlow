import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';
import 'package:vitaflow/ui/pages/survey/surveyScreen.dart';

import '../../home/theme.dart';

class Survey6 extends StatefulWidget {
  const Survey6({Key? key}) : super(key: key);

  @override
  State<Survey6> createState() => _Survey6State();
}

class _Survey6State extends State<Survey6> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<Survey>(context);

    return Padding(
        padding: EdgeInsets.all(defMargin),
        child: Column(children: [
          Text(
            'Pertanyaan 6',
            style: GoogleFonts.poppins(fontSize: subheaderSize),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Berat badan yang ingin dicapai?',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 4.h,
          ),
          FlutterToggleTab(
              width: 20.w,
              isScroll: false,
              labels: ['Kilogram', 'lbs'],
              selectedBackgroundColors: [Colors.white],
              selectedLabelIndex: ((p0) {
                setState(() {
                  _selected = p0;
                });
                if (_selected == 0) {
                  setState(() {
                    survey.weightFormat = WeightFormat.kg;
                  });
                } else {
                  setState(() {
                    survey.weightFormat = WeightFormat.lbs;
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
                  initialValue: survey.targetBB.toString(),
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: survey.weightFormat == WeightFormat.kg
                        ? "Berat badan (kg)"
                        : "Berat badan (lbs)",
                  ),
                  onChanged: (value) {
                    setState(() {
                      survey.targetBB = int.tryParse(value) ?? 0;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 2.h,
              ),
              Text(survey.weightFormat == WeightFormat.kg ? 'kg' : 'lbs',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600))
            ],
          )
        ]));
  }
}
