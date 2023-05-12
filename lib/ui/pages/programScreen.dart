import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/core/viewmodels/program/program_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/ProgramCard.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/top_bar.dart';

import '../../core/viewmodels/connection/connection.dart';
import '../widgets/loading/LoadingSingleBox.dart';

class ProgramScreen extends StatelessWidget {
  const ProgramScreen({Key? key}) : super(key: key);

  // list programs

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> programs = [
      {
        'title': 'Program menaikan berat badan',
        'description': 'Program yang membantu kamu untuk menaikan berat badan',
        'image':
            'https://images.unsplash.com/photo-1554139844-af2fc8ad3a3a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
      },
      {
        'title': ' Program diet',
        'description':
            'Program yang membantu kamu untuk menurunkan berat badan',
        'image':
            'https://lh3.googleusercontent.com/36V4amoNa2sA8irICyyWeAiu78vQ6D_26VAXv8oPOb8bl5BXlFuQ2NCrjunvmBNn2QBaVPAkx-KHwjh4FrF7N2UFYMYpokw6QmvGaqY'
      },
      {
        'title': 'Program naik badan di gym',
        'description': 'Program menaikan badan dengan plan olaharaga di gym',
        'image':
            'https://images.unsplash.com/photo-1590556409324-aa1d726e5c3c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
      },
    ];

    return Scaffold(
      backgroundColor: lightModeBgColor,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (create) => ProgramProvider())
        ],
        child: const ProgramBody(),
      ),
    );
  }
}

class ProgramBody extends StatelessWidget {
  const ProgramBody({Key? key}) : super(key: key);

  Future<void> refreshHome(BuildContext context) async {
    final programProv = ProgramProvider.instance(context);

    programProv.clearProducts();

    ConnectionProvider.instance(context).setConnection(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectionProvider>(builder: (context, connProv, _) {
      if (connProv.internetConnected == false) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Tidak Ada Koneksi Internet"),
              ElevatedButton(
                onPressed: () => refreshHome(context),
                child: const Text("Refresh"),
              )
            ],
          ),
        );
      }

      return SafeArea(
          child: RefreshIndicator(
        onRefresh: (() => refreshHome(context)),
        child: Column(
          children: [
            MainTopBar(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  Text(
                    "Program Unggulan VitaFlow",
                    style: normalText.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Consumer<ProgramProvider>(builder: (context, progProv, _) {
                    if (progProv.programs == null && !progProv.onSearch) {
                      progProv.getPrograms();

                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: defMargin),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const LoadingSingleBox(),
                      );
                    }

                    if (progProv.programs == null && progProv.onSearch) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: defMargin),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const LoadingSingleBox(),
                      );
                    }

                    if (progProv.programs!.isEmpty) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child:
                              const Text('Tidak ada program tersedia saat ini'),
                        ),
                      );
                    }

                    return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 50.h,
                        autoPlayInterval: Duration(seconds: 5),
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        enlargeCenterPage: true,
                        
                      ),
                      items: progProv.programs!.map((program) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ProgramCard(
                              title: program.programName,
                              description: program.programDescription,
                              image: program.image,
                            );
                          },
                        );
                      }).toList(),
                    );
                  }),
                  SizedBox(
                    height: 33,
                  ),
                  Container(
                    height: 55,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: primaryColor),
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Dalam pengembangan");
                      },
                      child: Text('Gabung Program',
                          style: TextStyle(color: primaryColor)),
                    ),
                  ),
                ],
              ),
            ),
            // button join with primary color
          ],
        ),
      ));
    });
  }
}
