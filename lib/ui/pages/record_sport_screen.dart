import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/CustomAppBar.dart';
import 'package:vitaflow/ui/widgets/burned_calori_bar.dart';
import 'package:vitaflow/ui/widgets/exercise_schedule.dart';

import '../widgets/KaloriProgressBar.dart';
import '../widgets/button.dart';

class RecordSportScreen extends StatefulWidget {
  const RecordSportScreen({Key? key}) : super(key: key);

  @override
  State<RecordSportScreen> createState() => _RecordSportScreenState();
}

class _RecordSportScreenState extends State<RecordSportScreen> {
  //status: 0=lock, 1=available, 2=done
  final List<Map<String, dynamic>> _exercises = [
    {
      "week": 1,
      "days": [
        {
          "day": 1,
          "status": 1,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 10,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 15,
              "set": 10,
              "status": false
            },
          ],
        },
        {
          "day": 2,
          "status": 0,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
          ],
        },
        {
          "day": 3,
          "status": 0,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
          ],
        },
        {
          "day": 4,
          "status": 0,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
          ],
        },
        {
          "day": 5,
          "status": 0,
          "title": "Seluruh tubuh",
          "description":
              "Latihan ini berfokus untuk memaksimalkan seluruh anggota tubuh",
          "exercises": [
            {
              "img": "assets/images/sport1.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
            {
              "img": "assets/images/sport2.png",
              "title": "Peregangan kobra",
              "durasi": 30,
              "set": 16,
              "status": false
            },
          ],
        }
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Aktivitas Olahraga',
        backgroundColor: lightModeBgColor,
        elevation: 0,
        leading: CustomBackButton(onClick: () {
          Navigator.pop(context);
        }),
      ),
      backgroundColor: lightModeBgColor,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(defMargin),
              children: [
                Center(child: BurnCaloriBar(value: 300, width: 200)),
                SizedBox(
                  height: 6.h,
                ),
                const Center(
                  child: Text(
                    "Target: 300 kalori",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff333333),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                const Text(
                  "Exercise Plan",
                  style: TextStyle(
                    fontSize: headerSize,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff333333),
                  ),
                ),
                ExerciseSchedule(exercises: _exercises)
              ],
            ),
          )
        ],
      )),
    );
  }
}
