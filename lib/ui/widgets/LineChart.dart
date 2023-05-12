import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:vitaflow/dummy/PricePoint.dart';



class LineChartHeartRate extends StatelessWidget {
  final List<FlSpot> points;

  const LineChartHeartRate(this.points, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.9,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: points.map((point) => FlSpot(point.y, point.y)).toList(),
              isCurved: false,
              dotData: FlDotData(show: false),
              color: Color(0XFF372534),
            ),
          ],
          borderData: FlBorderData(border: const Border()),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
  }

    SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          switch (value.toInt()) {
            case 0:
              return Text('00.00');
            case 4:
              return Text('04.00');
            case 8:
              return Text('08.00');
            case 12:
              return Text('12.00');
            case 16:
              return Text('16.00');
            case 20:
              return Text('20.00');
            case 24:
              return Text('24.00');
            default:
              return Text('');
          }
        },
      );

  
}
