import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/budget.dart';
import 'package:butterfly_finance/view_models/budget_view_model.dart';

void main() {
  late DatabaseService databaseService;
  late Isar isar;

  setUp(() async {
    final directory = Directory.systemTemp.createTempSync();

    isar = await Isar.open(
      [BudgetSchema],
      directory: directory.path,
    );

    // Initialize the database service with the mock Isar instance
    databaseService = DatabaseService();
    databaseService.isar = isar;
  });

  tearDown(() async {
    await databaseService.closeDatabase(deleteFromDisk: true);
  });

  group('BudgetViewModel Tests', () {
    late BudgetViewModel budgetViewModel;

    setUp(() {
      // Initialize the BudgetViewModel with the DatabaseService
      budgetViewModel = BudgetViewModel(databaseService);
    });

    test('Add and Retrieve Budget', () async {
      final testBudget = Budget()
        ..category = 'Groceries'
        ..amount = 500.0;

      await budgetViewModel.addBudget(testBudget);
      final budgets = await budgetViewModel.getAllBudgets();
      expect(budgets.isNotEmpty, true);
      expect(budgets.first.category, equals('Groceries'));
    });
  });
}
