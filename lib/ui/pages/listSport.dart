import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/button.dart';
import 'package:vitaflow/ui/widgets/sport_item.dart';
import 'package:vitaflow/ui/widgets/top_bar.dart';

class ListSport extends StatefulWidget {
  final Map<String, dynamic> data;

  const ListSport({super.key, required this.data});

  @override
  State<ListSport> createState() => _ListSportState();
}

class _ListSportState extends State<ListSport> {
  late ScrollController _scrollController;
  double lPad = 16.0, bPad = 16.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          lPad = _isSliverAppBarExpanded ? kToolbarHeight : 16;
          // bPad = _isSliverAppBarExpanded ? 12 : 16;
        });
      });
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xff149968),
            expandedHeight: 30.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding:
                  EdgeInsetsDirectional.only(start: lPad, bottom: bPad),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hari ${widget.data['day']}",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: bodySize),
                  ),
                  Text(
                    widget.data['title'],
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: subheaderSize),
                  ),
                ],
              ),
              background: Stack(children: [
                Image.asset(
                  'assets/images/bg_sport.png',
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset('assets/images/sportModel1.png')),
              ]),
            ),
          ),
          SliverFillRemaining(
            child: Container(
                color: Colors.white,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(defMargin),
                  children: [
                    Text(
                      'Tujuan',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: headerSize),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      widget.data['description'],
                      style: GoogleFonts.poppins(
                          color: Colors.grey, fontSize: subheaderSize),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Latihan',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: headerSize),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.data['exercises'].length,
                      itemBuilder: (c, i) {
                        var item = widget.data['exercises'][i];
                        return SportItem(
                            title: item['title'],
                            durasi: item['durasi'],
                            imgAddress: item['img']);
                      },
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
