import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isAuth = false;

  @override
  void initState() {
    // TODO: implement initState
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (ctx, orient, type) {
      return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/images/fitness.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              color: Colors.black54,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: defMargin, vertical: 4.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Raih impianmu dengan tubuh yang sehat dan bugar',
                        softWrap: true,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      RoundedButton(
                          title: 'MULAI SEKARANG',
                          style: GoogleFonts.poppins(color: Colors.white),
                          background: primaryColor,
                          onClick: () {}),
                      SizedBox(
                        height: 2.h,
                      ),
                      RoundedButton(
                          title: 'SAYA MEMPUNYAI AKUN',
                          style: GoogleFonts.poppins(color: primaryDarkColor),
                          background: Colors.white,
                          onClick: () {
                            Navigator.pushNamed(context, '/login');
                          }),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}
