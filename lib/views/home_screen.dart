import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const aspectRatio = 1.618033988749895; // Golden ratio
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Finance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: aspectRatio,
          children: <Widget>[
            _buildCard(context, 'Net Worth Tracking', Icons.trending_up,
                'net_worth_tracking_screen.dart'),
            _buildCard(context, 'Budget Management',
                Icons.account_balance_wallet, 'budget_management_screen.dart'),
            _buildCard(context, 'Spending Analysis', Icons.analytics,
                'spending_analysis_screen.dart'),
            _buildCard(context, 'Transaction History', Icons.history,
                'transaction_history_screen.dart'),
            _buildCard(context, 'Account Linking', Icons.link,
                'account_linking_screen.dart'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, IconData icon, String route) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 48.0),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
