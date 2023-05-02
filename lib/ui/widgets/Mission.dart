import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/MissionCard.dart';

class Mission extends StatelessWidget {
  Mission({Key? key, required this.finishMisison, required this.totalMission})
      : super(key: key);

  int finishMisison = 0;
  int totalMission = 6;

  List<Map<String, dynamic>> missions = [
    {
      "progress": 0.2,
      "missionColor": 0xff0BB576,
      "title": "Catat Aktivitas Makanan",
      "target": 2000,
      "current": 400,
      "pointReward": 50,
      "unit": "kalori",
      "icon": "assets/images/icon_misi_1.png",
      "backgroundColor": 0xffF6F8FA,
      'screen': '/food-record'
    },
    {
      "progress": 0.5,
      "missionColor": 0xff1F4DEF,
      "title": "Catat Aktivitas Olahraga",
      "target": 300,
      "current": 150,
      "unit": "kalori",
      "pointReward": 20,
      "icon": "assets/images/icon_misi_2.png",
      "backgroundColor": 0xffCBD6F8,
      'screen': '/record-sport'
    },
    {
      "progress": 0.5,
      "missionColor": 0xffF39CFF,
      "title": "Berjalan 10.000 langkah",
      "target": 10000,
      "current": 5000,
      "pointReward": 100,
      "unit": "langkah",
      "icon": "assets/images/icon_misi_3.png",
      "backgroundColor": 0xffF5E6FB,
      'screen': 'record-sport-run'
    },
    {
      "progress": 0.8,
      "missionColor": 0xff7BDFFF,
      "title": "Minum air putih",
      "target": 8,
      "current": 6,
      "pointReward": 25,
      "unit": "gelas",
      "icon": "assets/images/icon_misi_4.png",
      "backgroundColor": 0xffE0F3FA,
      'screen': '/water-record'
    },
    {
      "progress": 0.0,
      "missionColor": 0xff8D5EBC,
      "title": "Catat berat  badan",
      "target": 0,
      "current": 0,
      "pointReward": 5,
      "unit": "kg",
      "icon": "assets/images/icon_misi_5.png",
      "backgroundColor": 0xffE4DDEF,
      'screen': 'record-weight'
    },
    {
      "progress": 1.0,
      "missionColor": 0xffEF4F28,
      "title": "Check Kesehatan anda",
      "target": 0,
      "current": 56,
      "pointReward": 5,
      "unit": "bpm",
      "icon": "assets/images/icon_misi_6.png",
      "backgroundColor": 0xffF5D6D0,
      'screen': '/vita-pulse'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Misi kamu hari ini ",
              style: normalText.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            Text(
              "(" +
                  finishMisison.toString() +
                  "/" +
                  totalMission.toString() +
                  ")",
              style: normalText.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: ChangeNotifierProvider(
            create: (context) => UserProvider(),
            child: Consumer<UserProvider>(
              builder: (context, userProvider, _) {
                if (userProvider.myMission == null &&
                    !userProvider.onSearch) {
                  userProvider.getMyMission();
                  return Center(child: CircularProgressIndicator());
                }

                if (userProvider.myMission == null && userProvider.onSearch) {
                  return Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: userProvider.myMission!
                      .map((e) => MissionCard(

                            progress: e.percentageSuccess.toDouble(),
                            missionColor: e.colorTheme,
                            title: e.name,
                            target: e.target,
                            current: e.current,
                            pointReward: e.point,
                            unit: e.typeTarget,
                            icon: e.icon,
                            backgroundColor: e.colorTheme,
                            screen: e.name,

                        
                           
                          ))
                      .toList(),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
