import 'package:flutter/material.dart';

class FinancialHealthScore extends StatelessWidget {
  const FinancialHealthScore({Key? key}) : super(key: key);

  // Calculate the financial health score
  double _calculateScore(
      double debtToIncomeRatio, double spendingToEquityRatio) {
    return 1 - (debtToIncomeRatio + spendingToEquityRatio) / 2;
  }

  // Determine the grade based on the score
  String _determineGrade(double score) {
    switch (score) {
      case >= 0.8:
        return 'A';
      case >= 0.6:
        return 'B';
      case >= 0.4:
        return 'C';
      case >= 0.2:
        return 'D';
      default:
        return 'F';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double score = _calculateScore(0.08, 0.13);
    String grade = _determineGrade(score);

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Financial Health Grade',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              grade,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color.lerp(Colors.red, Colors.green, score),
              ),
            ),
            Text(
              '${(100 * score).toStringAsFixed(2)}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
