import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:butterfly_finance/view_models/transaction_view_model.dart';
import 'package:butterfly_finance/models/transaction.dart';
import 'package:butterfly_finance/services/database_service.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  group('Transaction ViewModel Tests', () {
    final databaseService = MockDatabaseService();
    final viewModel = TransactionViewModel(databaseService: databaseService);
    final transactions = [
      Transaction(
        transactionId: '1',
        accountId: '1',
        date: DateTime.now(),
        amount: -50.0,
        category: 'Groceries',
        description: 'Grocery shopping',
      ),
    ];

    test('Should load transactions successfully', () async {
      when(databaseService.getAllTransactions())
          .thenAnswer((_) async => transactions);

      await viewModel.loadTransactions();
      expect(viewModel.transactions.isNotEmpty, true);
      expect(viewModel.transactions.first.amount, -50.0);
    });

    // Consider adding more tests to cover scenarios like transaction categorization,
    // filtering by date or amount, and handling empty or error states.
  });
}
