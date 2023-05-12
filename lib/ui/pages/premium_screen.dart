import 'package:flutter/material.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/pages/home_screen.dart';
import 'package:vitaflow/ui/pages/main_pages.dart';
import 'package:vitaflow/ui/pages/payment_screen.dart';

import '../../core/models/transaction/transaction_model.dart';
import '../home/theme.dart';
import '../widgets/CustomAppBar.dart';
import '../widgets/button.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
     String  plantType = 'monthly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightModeBgColor,
//       floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked ,
//       floatingActionButton: Container(
//   padding: const EdgeInsets.symmetric(horizontal: 16),
//   color: Color(0xffF6F8FA),
//   width: double.infinity,
//   height: 150,
//   child: Column(
//     children: [
//       FloatingActionButton.extended(
//         onPressed: () {
//           // Free trial action
//         },
//         label: Container(
//           width:  double.infinity,
//           color: Colors.red,
//           child: Text("Berlangganan"),
//         )
//       ),
//       FloatingActionButton.extended(
//         onPressed: () {
//           // Berlangganan action
//         },
//         label: Text("Berlangganan",
//           style: normalText.copyWith(
//             color: Colors.white, fontWeight: FontWeight.w600)),
//         backgroundColor: primaryColor,
//       ),
//     ],
//   ),
// ),




      appBar: CustomAppBar(
        title: 'VitaFlow Premium',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: CustomBackButton(onClick: () {
          Navigator.pop(context);
        }),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih paket berlangganan',
              style: normalText.copyWith(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              "Langganan bulanan atau tahunan? Pilih sesuai tujuanmu! ",
              style: normalText.copyWith(
                  fontSize: 14,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // Paket bulanan
              GestureDetector(
                onTap: () {
                  
                  setState(() {
                    
                    plantType = 'monthly';
                
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border : Border.all(color: plantType == 'monthly' ? primaryColor : Colors.transparent, width: 2), 
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Bulanan',
                        style: normalText.copyWith(
                          fontSize: 16,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rp 30.000 / bulan',
                        style: normalText.copyWith(
                          fontSize: 14,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Langganan  selanjutnya akan dikenakan biaya sebesar Rp 25.000 / bulan ',
                        style: normalText.copyWith(
                          fontSize: 12,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    plantType = 'yearly';
 
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.44,
                  height: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border : Border.all(color: plantType == 'yearly' ? primaryColor : Colors.transparent , width: 2),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Tahunan',
                        style: normalText.copyWith(
                          fontSize: 16,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rp 299.000/tahun',
                        style: normalText.copyWith(
                          fontSize: 14,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lebih hemat 17% dibandingkan berlangganan bulanan',
                        style: normalText.copyWith(
                          fontSize: 12,
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 30,
            ),
            Text(
              'Manfaat premium',
              style: normalText.copyWith(
                  fontSize: 16,
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            PremiumFeature(),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By subscribe to , you agree to our ',
                  style: normalText.copyWith(
                    fontSize: 14,
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: normalText.copyWith(
                        fontSize: 14,
                        color: Color.fromARGB(255, 50, 44, 44),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: normalText.copyWith(
                        fontSize: 14,
                        color: const Color(0xff333333),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: normalText.copyWith(
                        fontSize: 14,
                        color: const Color(0xff333333),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Tambahkan kode untuk menangani aksi saat tombol berlangganan ditekan
                        // Tambahkan kode untuk menangani aksi saat tombol free trial ditekan
                        final UserProvider _userProvider = UserProvider();

                        // call user provider method active free trial
                        TransactionModel result = await 
                            _userProvider.paymentPremium(
                           plantType,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Tunggu yah kami sedang menyiapkan pembayaran '),
                          ),
                        );
                        // delay
                        Future.delayed(const Duration(seconds: 2), () {
                             Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentPage(
                                          grossAmount:  result.grossAmount.toString(),
                                          transactionId:  result.transactionId.toString(),
                                          paymentType:  result.paymentType.toString(),
                                          bank:  result.bank.toString(),
                                          vaNumber:  result.vaNumber.toString(),
                                          expireTimeStr:  result.expireTimeStr.toString(),
                                          expireTimeUnix:  result.expireTimeUnix,
                                          
                                      )))
                              .then((value) {
                            if (value != null && value == true) {
                              // Refresh widget disini
                            }
                          });
                        });


                      },
                      child: Text(
                        'Berlangganan',
                        style: normalText.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor, // warna latar
                        padding:
                            const EdgeInsets.symmetric(vertical: 16), // padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ), // bentuk
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        // Tambahkan kode untuk menangani aksi saat tombol free trial ditekan
                        final UserProvider _userProvider = UserProvider();

                        // call user provider method active free trial
                        _userProvider.activeTrial();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Yeyy kamu mendapatkan free trial selama 7 hari '),
                          ),
                        );
                        // delay
                        Future.delayed(const Duration(seconds: 2), () {
                          // pop screen
                          Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPages()))
                              .then((value) {
                            if (value != null && value == true) {
                              // Refresh widget disini
                            }
                          });
                        });
                      },
                      child: Text(
                        'Coba Gratis',
                        style: normalText.copyWith(
                          fontSize: 16,
                          color: primaryColor, // warna teks
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(vertical: 16), // padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ), // bentuk
                        side: BorderSide(
                          color: primaryColor, // warna garis pinggir
                          width: 2, // ketebalan garis pinggir
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class PremiumFeature extends StatelessWidget {
  const PremiumFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffe5e5e5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildFeature('Unlimited vitabot', Icons.check_box),
              ),
              Expanded(
                child: _buildFeature('Exercie Plan', Icons.check_box),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildFeature('Meal Plan', Icons.check_box),
              ),
              Expanded(
                child: _buildFeature('Vita coach AI ', Icons.check_box),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: primaryColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: normalText.copyWith(
            fontSize: 14,
            color: const Color(0xff333333),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
