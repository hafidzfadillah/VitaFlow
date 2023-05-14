import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/core/utils/navigation/navigation_utils.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/survey/surveyProvider.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: Text(
              'Mohon tunggu',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: neutral90,
                  fontSize: subheaderSize),
            ),
          ),
        ],
      ),
    );
  }
}
