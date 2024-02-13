import 'package:flutter/material.dart';

class BudgetUsageBars extends StatelessWidget {
  final List<BudgetCategory> categories = [
    BudgetCategory(name: 'Groceries', used: 150, total: 300),
    BudgetCategory(name: 'Utilities', used: 70, total: 100),
    BudgetCategory(name: 'Entertainment', used: 200, total: 200),
    // Add more categories as needed
  ]..sort((a, b) => (b.used / b.total).compareTo(a.used / a.total));

  BudgetUsageBars({Key? key}) : super(key: key);

  Color _getUsageColor(double percentage) {
    if (percentage < 0.5) {
      return Colors.green;
    } else if (percentage < 0.75) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Ensures the ListView only occupies space it needs
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final double usagePercentage = category.used / category.total;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category.name),
              SizedBox(height: 4),
              Stack(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: usagePercentage,
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: _getUsageColor(usagePercentage),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              Text('${(usagePercentage * 100).toStringAsFixed(0)}%'),
            ],
          ),
        );
      },
    );
  }
}

class BudgetCategory {
  final String name;
  final double used;
  final double total;

  BudgetCategory({required this.name, required this.used, required this.total});
}
