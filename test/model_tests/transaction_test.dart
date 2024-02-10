import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/transaction.dart';

void main() {
  group('Transaction Model Tests', () {
    test('should correctly initialize a Transaction object', () {
      final transaction = Transaction()
        ..transactionId = 'tx123'
        ..accountId = 'acc123'
        ..date = DateTime(2022, 1, 1)
        ..amount = 500.0
        ..category = 'Groceries'
        ..description = 'Weekly groceries';

      // Verify the fields are correctly assigned
      expect(transaction.transactionId, 'tx123');
      expect(transaction.accountId, 'acc123');
      expect(transaction.date, DateTime(2022, 1, 1));
      expect(transaction.amount, 500.0);
      expect(transaction.category, 'Groceries');
      expect(transaction.description, 'Weekly groceries');
    });
  });
}
