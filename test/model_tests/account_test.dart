import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/account.dart';

void main() {
  group('Account Model Tests', () {
    test('should correctly initialize an Account object', () {
      final account = Account()
        ..accountId = '123'
        ..accountName = 'Test Account'
        ..accountType = 'Savings'
        ..balance = 1000.0;

      // Verify the fields are correctly assigned
      expect(account.accountId, '123');
      expect(account.accountName, 'Test Account');
      expect(account.accountType, 'Savings');
      expect(account.balance, 1000.0);
    });
  });
}
