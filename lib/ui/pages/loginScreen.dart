import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/button.dart';

import '../widgets/input_costume.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? email = TextEditingController(text: "");
  TextEditingController? password = TextEditingController(text: "");
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email wajib di isi'),
    EmailValidator(errorText: "Format email tidak valid")
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password wajib di isi'),
  ]);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (ctx, orient, type) {
      return Scaffold(
        backgroundColor: lightModeBgColor,
        appBar:  AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: CustomBackButton(onClick:  () {
            Navigator.pop(context);
          },
          )
        ),
        body: SafeArea(
            child: ListView(
          padding:  EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
              
                Text(
                  'Masuk',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 28),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text('Masuk untuk melanjutkan ke Vitaflow',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xff707070))),
                SizedBox(
                  height: 4.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        hintText: 'Masukan email anda',
                        state: email!,
                        labelText: 'Email',
                        
                        inputType: TextInputType.emailAddress,
                        validator: emailValidator,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomFormField(
                          hintText: 'Masukan password',
                          state: password!,
                          labelText: 'Password',
                          isSecure: true,
                          validator: passwordValidator),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Lupa password?",
                            style: secondaryText.copyWith(
                                fontSize: captionSize,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      RoundedButton(
                        title: 'MASUK',
                        style: GoogleFonts.poppins(color: Colors.white , fontSize: 16 , fontWeight: FontWeight.w500),
                        background: primaryColor,
                        onClick: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        width: double.infinity,
                        height:  54,

                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                text: 'Belum punya akun? ',
                                style: blackTextStyle.copyWith(
                                    fontSize: 14),
                                children: [
                              TextSpan(
                                text: 'Daftar Sekarang',
                                style: GoogleFonts.poppins(
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                              )
                            ])),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        )),
      );
    });
  }
}
