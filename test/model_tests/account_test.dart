import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/account.dart';

void main() {
  group('Account Model Tests', () {
    test('Should correctly initialize an Account object', () {
      final account = Account(
        accountId: '1',
        accountName: 'Checking',
        accountType: 'checking',
        balance: 1000.0,
      );

      expect(account.accountId, '1');
      expect(account.accountName, 'Checking');
      expect(account.accountType, 'checking');
      expect(account.balance, 1000.0);
    });
  });
}
