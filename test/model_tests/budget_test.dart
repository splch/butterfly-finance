import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/budget.dart';

void main() {
  group('Budget Model Tests', () {
    final budget =
        Budget(budgetId: '1', categoryId: 'groceries', amount: 500.0);

    test('Should correctly initialize a Budget object', () {
      expect(budget.budgetId, '1');
      expect(budget.categoryId, 'groceries');
      expect(budget.amount, 500.0);
    });

    // Add more tests for serialization if your model supports it
    // and any other model-specific logic you have implemented.
  });
}
