import 'package:flutter/material.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/pages/vita_pulse_screen.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';

import '../home/theme.dart';
import '../widgets/input_costume.dart';

class VitaAddHealthScreen extends StatefulWidget {
  const VitaAddHealthScreen({super.key});

  @override
  State<VitaAddHealthScreen> createState() => _VitaAddHealthScreenState();
}

class _VitaAddHealthScreenState extends State<VitaAddHealthScreen> {
  TextEditingController? bpm = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightModeBgColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 70,
            child: FloatingActionButton.extended(
              onPressed: () {
                // userProvider
                UserProvider userProvider = UserProvider();
                userProvider.storeBpm(int.parse(bpm?.text ?? "0"));
                // toast message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Berhasil menambahkan data detak jantung  anda '),
                  ),
                );
                // delay
                Future.delayed(const Duration(seconds: 2), () {
                  // pop screen
                  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VitaPulseScreen()))
                      .then((value) {
                    if (value != null && value == true) {
                      // Refresh widget disini
                    }
                  });
                });

              },
              label: Text("Simpan",
                  style: normalText.copyWith(
                      color: const Color(0xff372534), fontWeight: FontWeight.w600)),
              backgroundColor: const Color(0xffF5D6D0),
            )),
        appBar: CustomAppBar(
            title: 'Tambah data detak jantung manual',
            backgroundColor: lightModeBgColor,
            elevation: 0,
            leading: Card(
              elevation: 0,
              shape: const CircleBorder(),
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xff372534),
                    ),
                  )),
            )),
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            Text(
              "Masukan hasil detak jantung anda dalam bpm",
              style: normalText.copyWith(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w500),
            ),
            CustomFormField(
              hintText: 'Contoh : 122 (bpm)',
              state: bpm!,
              labelText: '',
              isSecure: false,
              inputType:  TextInputType.number,
            ),
          ],
        )));
  }
}
