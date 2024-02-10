import 'package:flutter/foundation.dart';
import 'package:butterfly_finance/models/budget.dart';
import 'package:butterfly_finance/services/database_service.dart';

class BudgetViewModel with ChangeNotifier {
  final DatabaseService _databaseService;

  BudgetViewModel(this._databaseService);

  Future<void> addBudget(Budget budget) async {
    await _databaseService.addBudget(budget);
    notifyListeners();
  }

  Future<List<Budget>> getAllBudgets() async {
    return _databaseService.getAllBudgets();
  }

  Future<void> updateBudget(Budget budget) async {
    await _databaseService.updateBudget(budget);
    notifyListeners();
  }

  Future<void> deleteBudget(int id) async {
    await _databaseService.deleteBudget(id);
    notifyListeners();
  }
}
