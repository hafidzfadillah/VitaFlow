import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/survey/survey1.dart';
import 'package:vitaflow/ui/pages/survey/survey2.dart';
import 'package:vitaflow/ui/pages/survey/survey3.dart';
import 'package:vitaflow/ui/pages/survey/survey4.dart';
import 'package:vitaflow/ui/pages/survey/survey5.dart';
import 'package:vitaflow/ui/pages/survey/survey6.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final PageController _pageViewController =
      PageController(initialPage: 0); // set the initial page you want to show
  double percentage = 1 / 6;
  int currentPage = 0;

  Survey survey = Survey();

  List<Widget> _screens = [
    Survey1(),
    Survey2(),
    Survey3(),
    Survey4(),
    Survey5(),
    Survey6()
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageViewController.dispose(); // dispose the PageController
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => survey,
      child: Scaffold(
        
          body: SafeArea(
            
            
            child: Padding(
                               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

              child: Column(
                    children: [
              _buildTopbar(context),
              Expanded(child: _screens[currentPage]
                  //     PageView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: _screens.length,
                  //   itemBuilder: ((context, index) {
                  //     return _screens[index];
                  //   }),
                  //   controller: _pageViewController,
                  //   // onPageChanged: (value) {
                  //   //   setState(() {
                  //   //     currentPage = value;
                  //   //   });
                  //   // },
                  // )
                  ),

             
    
       RoundedButton(
                    width: double.infinity,
                    background: primaryColor,
                    title: 'Lanjut',
                    height: 62,
                    
                    style: GoogleFonts.poppins(color: Colors.white , fontWeight:  FontWeight.w600, fontSize:  16),
                    onClick: () {
                      if (percentage == 6 / 6 || currentPage == 5) {
                        print('survey done');
                        survey.result();
                      } else {
                        setState(() {
                          percentage += 1 / 6;
                          currentPage += 1;
                        });
                      }
                    },
                  ),
       

                    ],
                  ),
            ),
          )),
    );
  }

  Widget _buildTopbar(context) {
    return Container(
      margin : EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          CustomBackButton(
            onClick: () {
              if (percentage <= 1 / 6 || currentPage == 0) {
                Navigator.pop(context);
              } else {
                setState(() {
                  percentage -= 1 / 6;
                  currentPage -= 1;
                });
              }
            },
          ),
          Expanded(
              child: Center(
            child: LinearPercentIndicator(
              width: 30.w,
              percent: percentage,
              backgroundColor: neutral30,
              progressColor: primaryColor,
              alignment: MainAxisAlignment.center,
            ),
          )),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Lewati',
              style: subtitleTextStyle2.copyWith(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
