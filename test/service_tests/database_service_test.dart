import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/budget.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  group('Database Service Tests', () {
    final databaseService = MockDatabaseService();
    final budget =
        Budget(budgetId: '1', categoryId: 'groceries', amount: 500.0);

    test('Should save and fetch budget data successfully', () async {
      when(databaseService.insertBudget(budget))
          .thenAnswer((_) async => '1'); // Assuming insert returns the ID
      when(databaseService.getBudget('1')).thenAnswer((_) async => budget);

      await databaseService.insertBudget(budget);
      final fetchedBudget = await databaseService.getBudget('1');

      expect(fetchedBudget, isNotNull);
      expect(fetchedBudget.budgetId, budget.budgetId);
      expect(fetchedBudget.amount, budget.amount);
    });
  });
}
