import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';
import 'package:vitaflow/ui/pages/survey/surveyScreen.dart';

import '../../home/theme.dart';

class Survey2 extends StatefulWidget {
  const Survey2({Key? key}) : super(key: key);

  @override
  State<Survey2> createState() => _Survey2State();
}

class _Survey2State extends State<Survey2> {
  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<Survey>(context);

    return Padding(
      padding: EdgeInsets.all(defMargin),
      child: Column(
        children: [
          Text(
            'Pertanyaan 2',
            style: GoogleFonts.poppins(fontSize: subheaderSize),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Berapa umur Anda sekarang?',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 4.h,
          ),
          NumberPicker(
            haptics: true,
            textStyle: GoogleFonts.poppins(
                fontSize: 28, fontWeight: FontWeight.w500, color: neutral60),
            selectedTextStyle: GoogleFonts.poppins(
                fontSize: 36, fontWeight: FontWeight.w600, color: primaryColor),
            value: survey.umur,
            minValue: 1,
            maxValue: 99,
            onChanged: (value) => setState(() => survey.umur = value),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Row(children: [
              // Icon(Icons.info_outline),
              // SizedBox(
              //   width: 2.h,
              // ),
              Expanded(
                child: Text(
                  'Informasi umur akan membantu kami untuk menentukan program yang sesuai dan kebutuhan tubuh Anda',
                  softWrap: true,
                  style: subtitleTextStyle2,
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
