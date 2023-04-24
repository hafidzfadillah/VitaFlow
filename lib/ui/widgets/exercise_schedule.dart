import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/button.dart';

class ExerciseSchedule extends StatefulWidget {
  final List<Map<String, dynamic>> exercises;

  const ExerciseSchedule({super.key, required this.exercises});

  @override
  State<ExerciseSchedule> createState() => _ExerciseScheduleState();
}

class _ExerciseScheduleState extends State<ExerciseSchedule> {
  int currentWeek = 0;
  int selectedDay = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                'Minggu 1',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: subheaderSize),
              ),
              Spacer(),
              Visibility(
                  child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    iconSize: 16,
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 16,
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ))
            ],
          ),
          Container(
            height: 15.h,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: widget.exercises[currentWeek]["days"].length,
              itemBuilder: (c, i) {
                int status = widget.exercises[currentWeek]["days"][i]['status'];
                int day = widget.exercises[currentWeek]["days"][i]["day"];

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedDay = i;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(defRadius),
                        color:
                            Color(i == selectedDay ? 0xffEDF8F4 : 0xffFFFFFF)),
                    child: Column(
                      children: [
                        widget.exercises[currentWeek]["days"][i]['status'] == 0
                            ? Icon(
                                Icons.lock,
                                color: Color(0xffCECECE),
                                size: 32,
                              )
                            : Icon(
                                Icons.check_circle,
                                color: status == 2
                                    ? primaryColor
                                    : Color(0xffCECECE),
                                size: 32,
                              ),
                        Spacer(),
                        Text(
                          "Hari $day",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Visibility(
                            visible: i == selectedDay,
                            child: Container(
                              height: 2,
                              margin: EdgeInsets.symmetric(horizontal: 1.h),
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                            ))
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 1.h,
                  childAspectRatio: 0.7),
            ),
          ),
          RoundedButton(
              title: 'Mulai olahraga terencana',
              style: GoogleFonts.poppins(color: Colors.white),
              background: primaryColor,
              onClick: () {
                Navigator.pushNamed(context, '/list-sport',
                    arguments: widget.exercises[currentWeek]['days']
                        [selectedDay]);
              },
              width: double.infinity),
          SizedBox(
            height: 2.h,
          ),
          RoundedOutlineButton(
              title: 'Catat aktivitas',
              style: GoogleFonts.poppins(color: primaryColor),
              color: primaryColor,
              onClick: () {
                Navigator.pushNamed(context, '/input-sport');
              },
              width: double.infinity),
        ],
      ),
    );
  }
}
