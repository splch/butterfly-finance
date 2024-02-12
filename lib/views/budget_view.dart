import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Overview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PieChart(
          PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 40,
            sections: [
              PieChartSectionData(
                color: Colors.blue,
                value: 30,
                title: 'Rent',
                radius: 50,
              ),
              PieChartSectionData(
                color: Colors.red,
                value: 20,
                title: 'Groceries',
                radius: 50,
              ),
              PieChartSectionData(
                color: Colors.green,
                value: 15,
                title: 'Utilities',
                radius: 50,
              ),
              PieChartSectionData(
                color: Colors.yellow,
                value: 35,
                title: 'Entertainment',
                radius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
