import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';
import 'package:vitaflow/ui/pages/survey/surveyScreen.dart';

class Survey3 extends StatefulWidget {
  const Survey3({Key? key}) : super(key: key);

  @override
  State<Survey3> createState() => _Survey3State();
}

class _Survey3State extends State<Survey3> {
  // Gender _selected = Gender.Pria;

  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<Survey>(context);

    return
      Column(
        children: [
          Text(
            'Pertanyaan 3',
          style: GoogleFonts.poppins(fontSize: 14),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            'Apa tujuan anda memakai aplikasi ini?',
            textAlign: TextAlign.center,
            style:
                surveyHeading,
          ),
          SizedBox(
            height: 4.h,
          ),
        
          GestureDetector(
            onTap: () {
              setState(() {
                survey.tujuan = "Menaikkan berat badan";
              });
            },
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
              decoration: BoxDecoration(
                  color: neutral30,
                  borderRadius: BorderRadius.circular(defMargin),
                  border: survey.tujuan == "Menaikkan berat badan"
                      ? Border.all(color: primaryColor)
                      : null),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Menaikkan berat badan',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: blackColor),
                  ),
                  ),
                  Radio(
                      value: "Menaikkan berat badan",
                      groupValue: survey.tujuan,
                      activeColor: primaryColor,
                      onChanged: ((value) {
                        setState(() {
                          survey.tujuan = "Menaikkan berat badan";
                        });
                      }))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                survey.tujuan = "Menurunkan berat badan";
              });
            },
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
              decoration: BoxDecoration(
                  color: neutral30,
                  borderRadius: BorderRadius.circular(defMargin),
                  border: survey.tujuan == "Menurunkan berat badan"
                      ? Border.all(color: primaryColor)
                      : null),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Menurunkan berat badan',
                  style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: blackColor),
                    )
                  ),
                  Radio(
                      value: "Menurunkan berat badan",
                      groupValue: survey.tujuan,
                      activeColor: primaryColor,
                      onChanged: ((value) {
                        setState(() {
                          survey.tujuan = "Menurunkan berat badan";
                        });
                      }))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                survey.tujuan = "Mempertahankan berat badan";
              });
            },
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
              decoration: BoxDecoration(
                  color: neutral30,
                  borderRadius: BorderRadius.circular(defMargin),
                  border: survey.tujuan == "Mempertahankan berat badan"
                      ? Border.all(color: primaryColor)
                      : null),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Mempertahankan berat badan',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: blackColor),
                    )
                  ),
                  Radio(
                      value: "Mempertahankan berat badan",
                      groupValue: survey.tujuan,
                      activeColor: primaryColor,
                      onChanged: ((value) {
                        setState(() {
                          survey.tujuan = "Mempertahankan berat badan";
                        });
                      }))
                ],
              ),
            ),
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
                  'Yuk, ceritakan tujuan utama Anda dalam menggunakan aplikasi ini! Apakah ingin menurunkan berat badan, menambah massa otot, atau menjaga berat badan ideal?',
                  softWrap: true,
                  textAlign: TextAlign.center,
                style: normalText.copyWith(
                  fontSize: 14,
                  color: Color(0xff707070),
                ),
                ),
              )
            ]),
          )
        ],
    
    );
  }
}
