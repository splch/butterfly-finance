import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Management'),
      ),
      body: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: [
            PieChartSectionData(
              color: Colors.red,
              value: 40,
              title: 'Groceries',
              radius: 50,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 30,
              title: 'Bills',
              radius: 50,
            ),
            // Add more sections here
          ],
        ),
      ),
    );
  }
}
