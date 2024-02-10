import 'package:flutter/foundation.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/transaction.dart';

class TransactionViewModel with ChangeNotifier {
  final DatabaseService databaseService;
  List<Transaction?> _transactions = [];

  List<Transaction?> get transactions => _transactions;

  TransactionViewModel({required this.databaseService});

  Future<void> loadTransactions() async {
    try {
      _transactions = await databaseService.getAllTransactions();
      notifyListeners(); // Notify listening widgets to rebuild with the new data
    } catch (e) {
      // Error handling: Log, set error state, show messages to users, etc.
      print('Error loading transactions: $e');
    }
  }

  // Here you can add functionality to add, update, or delete transactions,
  // and possibly to filter or sort the list of transactions.
}
