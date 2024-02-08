import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/net_worth_tracking_screen.dart';
import 'views/budget_management_screen.dart';
import 'views/spending_analysis_screen.dart';
import 'views/transaction_history_screen.dart';
import 'views/account_linking_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Butterfly Finance',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        'net_worth_tracking_screen.dart': (context) => NetWorthTrackingScreen(),
        'budget_management_screen.dart': (context) => BudgetManagementScreen(),
        'spending_analysis_screen.dart': (context) => SpendingAnalysisScreen(),
        'transaction_history_screen.dart': (context) =>
            TransactionHistoryScreen(),
        'account_linking_screen.dart': (context) => AccountLinkingScreen(),
      },
    );
  }
}
