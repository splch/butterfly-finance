import 'package:flutter/foundation.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/budget.dart';

class BudgetViewModel with ChangeNotifier {
  final DatabaseService databaseService;
  List<Budget> _budgets = [];

  List<Budget> get budgets => _budgets;

  BudgetViewModel({required this.databaseService});

  Future<void> loadBudgets() async {
    try {
      _budgets = await databaseService.getAllBudgets();
      notifyListeners(); // Notify any listening widgets to rebuild
    } catch (e) {
      // Ideally, handle errors more gracefully in a real app
      print('Error loading budgets: $e');
    }
  }

  // Additional functionality to add, update, or remove budgets can be implemented here
}
