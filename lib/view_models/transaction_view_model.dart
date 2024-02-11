import 'package:flutter/foundation.dart';
import 'package:butterfly_finance/models/transaction.dart';
import 'package:butterfly_finance/services/database_service.dart';

class TransactionViewModel with ChangeNotifier {
  final DatabaseService _databaseService;

  TransactionViewModel(this._databaseService);

  Future<void> addTransaction(Transaction transaction) async {
    await _databaseService.addTransaction(transaction);
    notifyListeners();
  }

  Future<List<Transaction>> getAllTransactions() async {
    return _databaseService.getAllTransactions();
  }

  Future<List<Transaction>> getMonthlyTransactions() async {
    final date = DateTime.now();
    return _databaseService.getTransactionsBetweenDates(
      DateTime(date.year, date.month, 1),
      DateTime(date.year, date.month + 1, 0),
    );
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _databaseService.updateTransaction(transaction);
    notifyListeners();
  }

  Future<void> deleteTransaction(int id) async {
    await _databaseService.deleteTransaction(id);
    notifyListeners();
  }
}
