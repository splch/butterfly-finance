import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/transaction.dart';

void main() {
  group('Transaction Model Tests', () {
    final transaction = Transaction(
      transactionId: '1',
      accountId: '1',
      date: DateTime(2024, 1, 1),
      amount: -100.0,
      category: 'Dining',
      description: 'Restaurant bill',
    );

    test('Should correctly initialize a Transaction object', () {
      expect(transaction.transactionId, '1');
      expect(transaction.accountId, '1');
      expect(transaction.date, DateTime(2024, 1, 1));
      expect(transaction.amount, -100.0);
      expect(transaction.category, 'Dining');
      expect(transaction.description, 'Restaurant bill');
    });

    // Here you can add more tests for any additional logic or methods within the Transaction model.
  });
}
