import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SpendingAnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spending Analysis'),
      ),
      body: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: BarTouchData(
            enabled: false,
          ),
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [BarChartRodData(toY: 8)],
              showingTooltipIndicators: [0],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [BarChartRodData(toY: 10)],
              showingTooltipIndicators: [0],
            ),
            // Add more groups here
          ],
        ),
      ),
    );
  }
}
