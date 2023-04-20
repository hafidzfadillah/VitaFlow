import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../home/theme.dart';
import '../widgets/button.dart';
import '../widgets/input_costume.dart';

class DaftarScreen extends StatefulWidget {
  const DaftarScreen({Key? key}) : super(key: key);

  @override
  State<DaftarScreen> createState() => _DaftarScreenState();
}

class _DaftarScreenState extends State<DaftarScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? name = TextEditingController(text: "");
  TextEditingController? email = TextEditingController(text: "");
  TextEditingController? password = TextEditingController(text: "");

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Email wajib diisi'),
    EmailValidator(errorText: "Format email tidak valid")
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password wajib diisi'),
    MinLengthValidator(8, errorText: 'Panjang password minimal 8 karakter'),
  ]);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (ctx, orient, type) {
      return Scaffold(
        backgroundColor: lightModeBgColor,
        body: SafeArea(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defMargin),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(
                  onClick: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'Daftar',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 24),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                          hintText: 'Masukan nama anda',
                          labelText: 'Nama',
                          state: name!,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r"[a-zA-Z]+|\s"),
                            )
                          ],
                          validator:
                              RequiredValidator(errorText: "Nama wajib diisi")),
                      SizedBox(
                        height: 2.h,
                      ),
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
                        height: 4.h,
                      ),
                      RoundedButton(
                          width: double.infinity,
                          title: 'DAFTAR',
                          style: GoogleFonts.poppins(color: Colors.white),
                          background: primaryColor,
                          onClick: () {}),
                      SizedBox(
                        height: 2.h,
                      ),
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
