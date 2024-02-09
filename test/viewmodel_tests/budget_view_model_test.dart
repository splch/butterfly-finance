import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:butterfly_finance/view_models/budget_view_model.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/budget.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  group('Budget ViewModel Tests', () {
    final databaseService = MockDatabaseService();
    final viewModel = BudgetViewModel(databaseService: databaseService);
    final budget =
        Budget(budgetId: '1', categoryId: 'groceries', amount: 500.0);

    test('Should load budgets successfully', () async {
      when(databaseService.getAllBudgets()).thenAnswer((_) async => [budget]);

      await viewModel.loadBudgets();
      expect(viewModel.budgets.isNotEmpty, true);
      expect(viewModel.budgets.first.amount, 500.0);
    });

    // Consider adding more tests to cover scenarios like failing to load budgets,
    // updating budgets, and handling empty states.
  });
}
