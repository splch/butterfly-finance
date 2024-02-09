import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/net_worth.dart';

void main() {
  group('Net Worth Model Tests', () {
    final netWorthRecord = NetWorth(
      recordId: '1',
      date: DateTime.now(),
      totalAssets: 10000.0,
      totalLiabilities: 5000.0,
      netWorth: 5000.0,
    );

    test('Should correctly initialize a NetWorth object', () {
      expect(netWorthRecord.recordId, '1');
      expect(netWorthRecord.totalAssets, 10000.0);
      expect(netWorthRecord.totalLiabilities, 5000.0);
      expect(netWorthRecord.netWorth, 5000.0);
    });

    // Add more tests for any additional logic or methods within the NetWorth model.
  });
}
