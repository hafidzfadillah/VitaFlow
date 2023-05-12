import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vitaflow/core/models/transaction/transaction_model.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/main_pages.dart';

import '../../core/viewmodels/user/user_provider.dart';

class PaymentPage extends StatefulWidget {
  final String grossAmount;
  final String transactionId;
  final String paymentType;
  final String bank;
  final String vaNumber;
  final int expireTimeUnix;
  final String expireTimeStr;

  const PaymentPage({
    Key? key,
    required this.grossAmount,
    required this.transactionId,
    required this.paymentType,
    required this.bank,
    required this.vaNumber,
    required this.expireTimeUnix,
    required this.expireTimeStr,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isPaymentVerified = false;

  @override
  Widget build(BuildContext context) {
    final formattedGrossAmount =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
            .format(double.parse(widget.grossAmount));

    final formattedExpireTime = DateFormat('dd MMMM yyyy, HH:mm').format(
        DateTime.fromMillisecondsSinceEpoch(widget.expireTimeUnix * 1000));

    if (_isPaymentVerified) {
      return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 70,
              child: FloatingActionButton.extended(
                onPressed: () async {
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
                },
                label: Text("Kembali ke Home",
                    style: normalText.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                backgroundColor: primaryColor,
              )),
          appBar: AppBar(
            title: const Text('Payment Details'),
            backgroundColor: primaryColor,
            elevation: 0,
          ),
          body: SafeArea(child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Pembayaran Berhasil",
                    style: normalText.copyWith(
                        fontSize: 24,
                        color: Colors.black, fontWeight: FontWeight.w600)),

                  Text("Terima kasih telah berlangganan Vita Premium  ",
                  textAlign:  TextAlign.center,
                  style: normalText.copyWith(
                      fontSize: 16,
                      
                      color: neutral70, fontWeight: FontWeight.w500)),
              ],

          )));
    }
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          height: 70,
          child: FloatingActionButton.extended(
            onPressed: () async {
              final UserProvider _userProvider = UserProvider();
              TransactionModel result =
                  await _userProvider.verifyPayment(widget.transactionId);

              setState(() {
                if (result.status == 1) {
                  _isPaymentVerified = true;
                } else {
                  _isPaymentVerified = false;
                  // snackbar 

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Pembayaran belum diverifikasi'),
                    ),
                  );
                }
              });
            },
            label: Text("Cek Status Pembayaran",
                style: normalText.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            backgroundColor: primaryColor,
          )),
      appBar: AppBar(
        title: const Text('Payment Details'),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Text('Payment Type: '),
                  Text(widget.paymentType),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Bank: '),
                  Text(widget.bank),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('VA Number: '),
                  Text(widget.vaNumber),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: widget.vaNumber));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to clipboard'),
                          ),
                        );
                      },
                      child: Icon(Icons.copy),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Transaction Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Transaction ID: '),
                  Expanded(child: Text(widget.transactionId)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Gross Amount: '),
                  Text(formattedGrossAmount),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Expiration Time: '),
                  Text(formattedExpireTime),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
