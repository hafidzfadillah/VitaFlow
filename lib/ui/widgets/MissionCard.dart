import 'package:flutter/material.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/widgets/mission_progress_circural_bar.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({
    Key? key,
    this.progress,
    this.missionColor,
    required this.title,
    required this.target,
    required this.current,
    required this.pointReward,
    required this.unit,
    required this.icon,
    this.backgroundColor,
    required this.screen,
  }) : super(key: key);

  final double? progress;
  final int? missionColor;
  final String title;
  final int target;
  final int current;
  final int pointReward;
  final String unit;
  final String icon;
  final int? backgroundColor;
  final String screen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        String titleLower = title.toLowerCase();

        if (titleLower == 'catat aktivitas makanan') {
          Navigator.of(context, rootNavigator: true).pushNamed('/food-record');
        } else if (titleLower == 'catat aktivitas olahraga') {
          Navigator.of(context, rootNavigator: true).pushNamed('/record-sport');
        } else if (titleLower == 'catat aktivitas lari/ jalan') {
          Navigator.of(context, rootNavigator: true)
              .pushNamed('/record-sport-run');
        } else if (titleLower == 'catat asupan minum') {
          Navigator.of(context, rootNavigator: true).pushNamed('/water-record');
        } else if (titleLower == 'catat berat badan') {
          Navigator.of(context, rootNavigator: true)
              .pushNamed('/record-weight');
        } else if (titleLower == 'check kesehatan anda') {
          Navigator.of(context, rootNavigator: true).pushNamed('/vita-pulse');
        } else {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(screen.toLowerCase());
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xffF6F8FA),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            MissionProgressCircuralBar(
              progress: progress ?? 0.0,
              size: 40,
              backgroundColor: Color(
                backgroundColor ?? 0xffF6F8FA,
              ),
              foregroundColor: Color(missionColor ?? 0xff0BB576),
              strokeWidth: 8,
              assetName: icon,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: normalText.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  target == 0
                      ? current == 0
                          ? '-' + ' ' + unit
                          : current.toString() + ' ' + unit
                      : current.toString() +
                          "/" +
                          target.toString() +
                          " " +
                          unit,
                  style: normalText.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      pointReward.toString() + " poin",
                      style: normalText.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff333333),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
