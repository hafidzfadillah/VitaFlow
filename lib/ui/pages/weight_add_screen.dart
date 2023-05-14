import 'package:flutter/material.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/pages/record_weight_screen.dart';
import 'package:vitaflow/ui/pages/vita_pulse_screen.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';

import '../home/theme.dart';
import '../widgets/input_costume.dart';

class WeightAddScreen extends StatefulWidget {
  const WeightAddScreen({super.key});

  @override
  State<WeightAddScreen> createState() => _WeightAddScreen();
}

class _WeightAddScreen extends State<WeightAddScreen> {
  TextEditingController? weight = TextEditingController(text: "");

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
                userProvider.storeWeight(int.parse(weight?.text ?? "0"));
                // toast message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('Berhasil menambahkan data berat badan anda '),
                  ),
                );
                // delay
                Future.delayed(const Duration(seconds: 2), () {
                  // pop screen
                  Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordWeightScreen()))
                      .then((value) {
                    if (value != null && value == true) {
                      // Refresh widget disini
                    }
                  });
                });
              },
              label: Text("Simpan",
                  style: normalText.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              backgroundColor: primaryColor,
            )),
        appBar: CustomAppBar(
            title: 'Tambah data berat badan manual',
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
              "Masukan berat badan terakhir anda",
              style: normalText.copyWith(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w500),
            ),
            CustomFormField(
              hintText: 'Contoh : 50 (kg)',
              state: weight!,
              labelText: '',
              isSecure: false,
              inputType: TextInputType.number,
            ),
          ],
        )));
  }
}
