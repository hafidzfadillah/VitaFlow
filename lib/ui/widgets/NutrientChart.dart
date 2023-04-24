import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class NutrientChart extends StatelessWidget {
  final double carbsPercentage;
  final double fatPercentage;
  final double proteinPercentage;

  const NutrientChart({
    Key? key,
    required this.carbsPercentage,
    required this.fatPercentage,
    required this.proteinPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegend('Karbohidrat', carbsPercentage),
              _buildLegend('Lemak', fatPercentage),
              _buildLegend('Protein', proteinPercentage),
            ],
          ),
        ),
        Expanded(
          child: 
              Container(
                padding : EdgeInsets.all(10),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius:0,
                      sections: _buildPieChartSections(),
                    ),
                  ),
                           
                        ),
              ),
        ),
      ],
    );
  }

  Widget _buildLegend(String label, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 7,
            height: 18,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: _getColorForLabel(label),
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
          Spacer(),
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: _getColorForLabel('Karbohidrat'),
      ),
      PieChartSectionData(
        color: _getColorForLabel('Lemak'),
      ),
      PieChartSectionData(
        color: _getColorForLabel('Protein'),
       
      ),
    ];
  }

  Color _getColorForLabel(String label) {
    switch (label) {
      case 'Karbohidrat':
        return Color(0xff0BB576);
      case 'Lemak':
        return Color(0xffFFDD60);
      case 'Protein':
        return Color(0xffF39CFF);
      default:
        return Colors.grey;
    }
  }
}
