import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/budget.dart';

void main() {
  group('Budget Model Tests', () {
    test('should correctly initialize a Budget object', () {
      final budget = Budget()
        ..budgetId = 'B123'
        ..categoryId = 'C456'
        ..amount = 500.0;

      // Verify the fields are correctly assigned
      expect(budget.budgetId, 'B123');
      expect(budget.categoryId, 'C456');
      expect(budget.amount, 500.0);
    });
  });
}
