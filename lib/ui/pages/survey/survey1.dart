import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';
import 'package:vitaflow/ui/pages/survey/surveyScreen.dart';

class Survey1 extends StatefulWidget {
  @override
  State<Survey1> createState() => _Survey1State();
}

class _Survey1State extends State<Survey1> {
  // Gender _selected = Gender.Pria;

  @override
  Widget build(BuildContext context) {
    final survey = Provider.of<SurveyProvider>(context);

    return 
       Column(
          children: [
            Text(
              'Pertanyaan 1',
              style: GoogleFonts.poppins(fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Jenis Kelamin Anda?',
              textAlign: TextAlign.center,
              style:
              surveyHeading
            ),
            SizedBox(
              height: 4.h,
            ),
            GestureDetector(
              onTap: () {
                // setState(() {
                survey.gender = Gender.Pria;
                // });
              },
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
                decoration: BoxDecoration(
                    color: neutral30,
                    borderRadius: BorderRadius.circular(defMargin),
                    border: survey.gender == Gender.Pria
                        ? Border.all(color: primaryColor)
                        : null),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Laki-laki',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: headerSize , color : blackColor),
                      ),
                    ),
                    Radio(
                        value: Gender.Pria,
                        groupValue: survey.gender,
                        activeColor: primaryColor,
                        onChanged: ((value) {
                          // setState(() {
                          survey.gender = Gender.Pria;
                          // });
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
                // setState(() {
                survey.gender = Gender.Wanita;
                // });
              },
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: defMargin),
                decoration: BoxDecoration(
                    color: neutral30,
                    borderRadius: BorderRadius.circular(defMargin),
                    border: survey.gender == Gender.Wanita
                        ? Border.all(color: primaryColor)
                        : null),
                child: Row(
                  children: [
                    Expanded(
                       child: Text(
                        'Perempuan',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: headerSize , color : blackColor),
                      ),
                   
                    ),
                    Radio(
                        value: Gender.Wanita,
                        groupValue: survey.gender,
                        activeColor: primaryColor,
                        onChanged: ((value) {
                          // setState(() {
                          survey.gender = Gender.Wanita;
                          // });
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
                    'Mengetahui gender penting untuk menghitung metabolisme tubuh agar program yang diberikan sesuai dengan kebutuhan Anda.',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: normalText.copyWith(
                      fontSize: 14,
                      color:  Color(0xff707070),
                    
                    ),
                    
                  ),
                )
              ]),
            )
          ],
   

    );
  }
}
