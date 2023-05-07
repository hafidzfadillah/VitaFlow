import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitaflow/core/models/mission/my_mission.dart';
import 'package:vitaflow/core/viewmodels/user/user_provider.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/MissionCard.dart';

class Mission extends StatelessWidget {
  Mission({Key? key, required this.myMission}) : super(key: key);

  int finishMisison = 0;
  int totalMission = 6;

  List<MyMissionModel>? myMission;

  // final totalMission =  myMission?.length;

  // final finishMissions =
  //     userProvider.myMission!.where((e) => e.status == 'finish');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),

        // Filter data yang memiliki status 'on-going'

        Column(
          children: [
            // Menampilkan jumlah tugas yang belum selesai
            Row(
              children: [
                Text(
                  "Misi kamu hari ini ",
                  style: normalText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff333333),
                  ),
                ),
                Text(
                  "${myMission?.where((element) => element.status == 'finish').length ?? 0}/${myMission?.length}",
                  style: normalText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff333333),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Menampilkan card misi
            Column(
              children: myMission!
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
            ),
          ],
        ),
      ],
    );
  }
}
