import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/transaction.dart';
import 'package:butterfly_finance/view_models/transaction_view_model.dart';

void main() {
  late DatabaseService databaseService;
  late Isar isar;

  setUp(() async {
    final directory = Directory.systemTemp.createTempSync();

    isar = await Isar.open(
      [TransactionSchema],
      directory: directory.path,
    );

    // Initialize the database service with the mock Isar instance
    databaseService = DatabaseService();
    databaseService.isar = isar;
  });

  tearDown(() async {
    await databaseService.closeDatabase(deleteFromDisk: true);
  });

  group('TransactionViewModel Tests', () {
    late TransactionViewModel transactionViewModel;

    setUp(() {
      // Initialize the TransactionViewModel with the DatabaseService
      transactionViewModel = TransactionViewModel(databaseService);
    });

    test('Add and Retrieve Transaction', () async {
      final testTransaction = Transaction()
        ..transactionId = 'tx123'
        ..accountId = 'acc123'
        ..date = DateTime.now()
        ..amount = -50.0
        ..category = 'Dining'
        ..description = 'Dinner at restaurant';

      await transactionViewModel.addTransaction(testTransaction);
      final transactions = await transactionViewModel.getAllTransactions();
      expect(transactions.isNotEmpty, true);
      expect(transactions.first.description, equals('Dinner at restaurant'));
    });
  });
}
