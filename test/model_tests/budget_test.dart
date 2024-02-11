import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/budget.dart';

void main() {
  group('Budget Model Tests', () {
    test('should correctly initialize a Budget object', () {
      final budget = Budget()
        ..category = 'Groceries'
        ..amount = 500.0;

      // Verify the fields are correctly assigned
      expect(budget.category, 'Groceries');
      expect(budget.amount, 500.0);
    });
  });
}
