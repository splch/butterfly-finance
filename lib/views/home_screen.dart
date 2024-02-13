import 'package:flutter/material.dart';
import 'package:butterfly_finance/views/accounts_view.dart';
import 'package:butterfly_finance/views/budget_view.dart';
import 'package:butterfly_finance/views/net_worth_view.dart';
import 'package:butterfly_finance/views/settings_view.dart';
import 'package:butterfly_finance/views/transactions_view.dart';
import 'package:butterfly_finance/widgets/net_worth_chart.dart';
import 'package:butterfly_finance/widgets/budget_chart.dart';
import 'package:butterfly_finance/widgets/transactions_list.dart';
import 'package:butterfly_finance/widgets/financial_health_score.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Finance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => navigateTo(context, SettingsView()),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        childAspectRatio: 3.0,
        children: <Widget>[
          _buildNavigationTile(context, 'Net Worth', AccountsView()),
          _buildNavigationTile(context, 'Financial Health', this),
          _buildNavigationTile(context, 'Budget', BudgetView()),
          _buildNavigationTile(context, 'Transactions', TransactionsView()),
        ],
      ),
    );
  }

  Widget _buildNavigationTile(
      BuildContext context, String title, Widget destination) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => navigateTo(context, destination),
        child: Center(
          child: _getNavigationTileContent(title),
        ),
      ),
    );
  }

  Widget _getNavigationTileContent(String title) {
    switch (title) {
      case 'Net Worth':
        return NetWorthChart();
      case 'Budget':
        return BudgetUsageBars();
      case 'Transactions':
        return TransactionsList();
      case 'Financial Health':
        return FinancialHealthScore();
      default:
        return Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        );
    }
  }

  void navigateTo(BuildContext context, Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }
}
