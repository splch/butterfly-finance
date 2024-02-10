import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/net_worth.dart';

void main() {
  group('NetWorth Model Tests', () {
    test('should correctly initialize a NetWorth object', () {
      final netWorth = NetWorth()
        ..date = DateTime(2022, 1, 1)
        ..totalAssets = 2000.0
        ..totalLiabilities = 500.0;

      // Verify the fields are correctly assigned
      expect(netWorth.date, DateTime(2022, 1, 1));
      expect(netWorth.totalAssets, 2000.0);
      expect(netWorth.totalLiabilities, 500.0);
    });

    test('should correctly calculate net worth', () {
      final netWorth = NetWorth()
        ..totalAssets = 2000.0
        ..totalLiabilities = 500.0;

      // Verify net worth calculation
      expect(netWorth.netWorth, 1500.0);
    });
  });
}
