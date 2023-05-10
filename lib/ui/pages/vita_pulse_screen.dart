import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vitaflow/dummy/PricePoint.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/history_card.dart';
import 'package:vitaflow/ui/widgets/LineChart.dart';
import 'package:vitaflow/ui/widgets/button.dart';

class VitaPulseScreen extends StatelessWidget {
  const VitaPulseScreen({Key? key}) : super(key: key);

  final bool isConnect = true;

  @override
  Widget build(BuildContext context) {
    if (isConnect == false) {
      return Scaffold(
        backgroundColor: lightModeBgColor,
        appBar: CustomAppBar(
          title: 'VitaPulse',
          backgroundColor: Colors.white,
          elevation: 0,
          leading: CustomBackButton(onClick: () {
            Navigator.pop(context);
          }),
        ),
        
        
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(bottom: 100),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 33),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/icon_misi_6.png'),
                SizedBox(height: 20),
                Text('Terhubung dengan VitaPulse',
                    style: normalText.copyWith(
                        fontSize: 16,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 16),
                Text(
                    'Untuk terhubung dengan Vitapulse , kamu perlu menyakalan bluetooth dan dekatkan dengan device VitaPulse',
                    textAlign: TextAlign.center,
                    style: normalText.copyWith(
                        fontSize: 14,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.w400)),
              ],
            )),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: lightModeBgColor,
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Color(0xffF5D6D0),
        child: const Icon(Icons.add , color: Color(0xff372534)),
      ),
  
      appBar: CustomAppBar(
          title: 'Hearth Rate',
          backgroundColor: Color(0xffF5D6D0),
          elevation: 0,
          leading: Card(
            elevation: 0,
            shape: CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xff372534),
                  ),  
                )),
          )),
      body: SafeArea(
          child: ListView(
        children: [
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Color(0xffF5D6D0),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "122bpm",
                        style: normalText.copyWith(
                            fontSize: 18,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height : 80),
                    Container(
                      child: LineChartHeartRate(heartRatePoints)),
                  ],
                ),
              )),
          SizedBox(height: 24),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "History Cek Kesehatan",
                  style: normalText.copyWith(
                      fontSize: 16,
                      color: Color(0xff333333),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 16,
                ),
                HistoryCard(
                    title: " Catatan detak jantung",
                    value: 122,
                    date: "Senin,12 Juli 2021",
                    unit: "bpn",
                    withTarget: false)
              ],
            ),
          ),

         
        ],
      )),
    );
  }
}
