import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/models/budget.dart';
import 'package:butterfly_finance/models/net_worth.dart';
import 'package:butterfly_finance/models/transaction.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/services/ml_service.dart';

void main() {
  late DatabaseService databaseService;
  late MLService mlService;
  late Isar isar;

  setUp(() async {
    final directory = Directory.systemTemp.createTempSync();

    isar = await Isar.open(
      [AccountSchema, BudgetSchema, NetWorthSchema, TransactionSchema],
      directory: directory.path,
    );

    databaseService = DatabaseService();
    databaseService.isar = isar;
    mlService = MLService(databaseService);
  });

  tearDown(() async {
    await databaseService.closeDatabase(deleteFromDisk: true);
  });

  group('MLService Tests', () {
    // Example: Test Net Worth Prediction
    test('Predict Net Worth', () async {
      // Setup: Insert net worth records
      final netWorthRecords = [
        NetWorth()
          ..date = DateTime.now().subtract(Duration(days: 365))
          ..totalAssets = 10000.0
          ..totalLiabilities = 5000.0,
        NetWorth()
          ..date = DateTime.now().subtract(Duration(days: 180))
          ..totalAssets = 12000.0
          ..totalLiabilities = 6000.0,
        NetWorth()
          ..date = DateTime.now()
          ..totalAssets = 15000.0
          ..totalLiabilities = 7000.0,
      ];

      for (var record in netWorthRecords) {
        await databaseService.addNetWorth(record);
      }

      // Act: Predict future net worth
      final predictionDate = DateTime.now().add(Duration(days: 30));
      final predictedNetWorth = await mlService.predictNetWorth(predictionDate);

      // Assert: Validate the prediction (exact validation depends on your model and data)
      expect(predictedNetWorth, isNotNull);
      expect(predictedNetWorth, isA<double>());
      expect(predictedNetWorth, greaterThan(0.0));
    });

    test('Predict Monthly Expenses', () async {
      // Setup: Insert transaction records
      final transactions = [
        Transaction()
          ..transactionId = '1'
          ..accountId = '1'
          ..date = DateTime.utc(2024, 2, 1)
          ..amount = -200.0
          ..category = 'Groceries'
          ..description = 'Groceries for the month',
        Transaction()
          ..transactionId = '2'
          ..accountId = '1'
          ..date = DateTime.utc(2024, 2, 15)
          ..amount = -300.0
          ..category = 'Utilities'
          ..description = 'Electricity bill',
      ];

      for (var transaction in transactions) {
        await databaseService.addTransaction(transaction);
      }

      // Act: Predict future monthly expenses
      final predictionDate = DateTime.utc(2024, 2, 28);
      final predictedExpenses =
          await mlService.predictMonthlyExpenses(predictionDate);

      // Assert: Validate the prediction
      expect(predictedExpenses, isNotNull);
      expect(predictedExpenses, isA<double>());
      expect(predictedExpenses, lessThan(0.0));
    });

    // late String accountId;
    // late String accountName;
    // late String accountType;
    // late double balance;

    test('Predict Account Risk', () async {
      // Setup: Insert an account and its transactions
      final account = Account()
        ..accountId = 'accRisk'
        ..accountName = 'Checking Account'
        ..accountType = 'Checking'
        ..balance = 1000.0;

      final _ = await databaseService.addAccount(account);

      final transactions = [
        Transaction()
          ..transactionId = '1'
          ..accountId = account.accountId
          ..date = DateTime.now().subtract(const Duration(days: 20))
          ..amount = -200.0
          ..category = 'Groceries'
          ..description = 'Groceries for the month',
        Transaction()
          ..transactionId = '2'
          ..accountId = account.accountId
          ..date = DateTime.now().subtract(const Duration(days: 15))
          ..amount = -300.0
          ..category = 'Utilities'
          ..description = 'Electricity bill',
      ];

      for (var transaction in transactions) {
        await databaseService.addTransaction(transaction);
      }

      // Act: Predict if the account is at risk
      final isAtRisk = await mlService.predictAccountRisk(account);

      // Assert: Validate the prediction
      expect(isAtRisk, isNotNull);
      expect(isAtRisk, isTrue);
    });

    test('Predict Budget Exceeded', () async {
      // Setup: Insert a budget and related transactions
      final budget = Budget()
        ..category = 'Groceries'
        ..amount = 500.0;

      final transactions = [
        Transaction()
          ..transactionId = '1'
          ..accountId = '1'
          ..date = DateTime(DateTime.now().year, DateTime.now().month, 2)
          ..amount = -200.0
          ..category = 'Groceries'
          ..description = 'Eggs and milk',
        Transaction()
          ..transactionId = '2'
          ..accountId = '1'
          ..date = DateTime(DateTime.now().year, DateTime.now().month, 5)
          ..amount = -100.0
          ..category = 'Groceries'
          ..description = 'Bread and butter',
      ];

      for (var transaction in transactions) {
        await databaseService.addTransaction(transaction);
      }

      // Act: Predict if the budget will be exceeded
      final isExceeded = await mlService.predictBudgetExceeded(budget);

      // Assert: Validate the prediction
      expect(isExceeded, isNotNull);
      expect(isExceeded, isA<bool>());
      expect(isExceeded, isTrue);
    });

    test('Predict Net Worth Exceeded', () async {
      // Setup: Insert net worth records
      final netWorthRecords = [
        NetWorth()
          ..date = DateTime.now().subtract(Duration(days: 365))
          ..totalAssets = 10000.0
          ..totalLiabilities = 5000.0,
        NetWorth()
          ..date = DateTime.now().subtract(Duration(days: 180))
          ..totalAssets = 12000.0
          ..totalLiabilities = 6000.0,
        NetWorth()
          ..date = DateTime.now()
          ..totalAssets = 50000.0
          ..totalLiabilities = 7000.0,
      ];

      for (var record in netWorthRecords) {
        await databaseService.addNetWorth(record);
      }

      // Act: Predict if a net worth record exceeds the expected value
      final isExceeded = await mlService.predictNetWorthExceeded(
        NetWorth()
          ..date = DateTime.now()
          // Subtracting a dummy value to simulate the current predicted assets
          ..totalAssets =
              await mlService.predictNetWorth(DateTime.now()) - 7000.0
          ..totalLiabilities = 7000.0,
      );

      // Assert: Validate the prediction
      expect(isExceeded, isNotNull);
      expect(isExceeded, isTrue);
    });
  });
}
