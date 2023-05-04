import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/workout_item.dart';

class InputWorkoutScreen extends StatefulWidget {
  const InputWorkoutScreen({Key? key}) : super(key: key);

  @override
  State<InputWorkoutScreen> createState() => _InputWorkoutScreenState();
}

class _InputWorkoutScreenState extends State<InputWorkoutScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController1 = TextEditingController(text: ""),
      _searchController2 = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.white,
        leading: CustomBackButton(onClick: () {
          Navigator.pop(context);
        }),
        title: 'Kegiatan Latihan',
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                    labelStyle: GoogleFonts.poppins(color: primaryColor),
                    labelColor: primaryColor,
                    unselectedLabelStyle:
                        GoogleFonts.poppins(color: blackColor),
                    unselectedLabelColor: blackColor,
                    tabs: [
                      Tab(
                        text: 'Pencarian',
                      ),
                      Tab(text: 'Kebanyakan latihan')
                    ]),
              ),
              Expanded(
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(defMargin),
                            child: TextFormField(
                              controller: _searchController1,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                prefixIcon: Icon(Icons.search,
                                    color: Color(0xffB8B8B8)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(defRadius),
                                  borderSide: BorderSide(
                                    color: Color(0xffEAE7E7),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(defRadius),
                                  borderSide: BorderSide(
                                    color: Color(0xffEAE7E7),
                                  ),
                                ),
                                hintText: 'Cari jenis aktivitas',
                                contentPadding: EdgeInsets.all(defMargin),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding:
                                  EdgeInsets.symmetric(horizontal: defMargin),
                              itemCount: 14,
                              itemBuilder: (c, i) {
                                return WorkoutItem(
                                    title: 'Workout $i',
                                    durasiDetik: i * 30,
                                    jmlKkal: i * 75);
                              },
                              separatorBuilder: (c, i) {
                                return Divider();
                              },
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(defMargin),
                            child: TextFormField(
                              controller: _searchController2,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                filled: true,
                                prefixIcon: Icon(Icons.search,
                                    color: Color(0xffB8B8B8)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(defRadius),
                                  borderSide: BorderSide(
                                    color: Color(0xffEAE7E7),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(defRadius),
                                  borderSide: BorderSide(
                                    color: Color(0xffEAE7E7),
                                  ),
                                ),
                                hintText: 'Cari jenis aktivitas',
                                contentPadding: EdgeInsets.all(defMargin),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding:
                                  EdgeInsets.symmetric(horizontal: defMargin),
                              itemCount: 14,
                              itemBuilder: (c, i) {
                                return WorkoutItem(
                                    title: 'Workout $i',
                                    durasiDetik: i * 30,
                                    jmlKkal: i * 75);
                              },
                              separatorBuilder: (c, i) {
                                return Divider();
                              },
                            ),
                          )
                        ],
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
