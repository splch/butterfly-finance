import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:butterfly_finance/view_models/net_worth_view_model.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/net_worth.dart';

class MockDatabaseService extends Mock implements DatabaseService {}

void main() {
  group('Net Worth ViewModel Tests', () {
    final databaseService = MockDatabaseService();
    final viewModel = NetWorthViewModel(databaseService: databaseService);
    final netWorthRecords = [
      NetWorth(
        recordId: '1',
        date: DateTime.now(),
        totalAssets: 20000.0,
        totalLiabilities: 5000.0,
        netWorth: 15000.0,
      ),
    ];

    setUp(() {
      when(databaseService.getAllNetWorthRecords())
          .thenAnswer((_) async => netWorthRecords);
    });

    test('Should load net worth records successfully', () async {
      await viewModel.loadNetWorthRecords();
      expect(viewModel.netWorthRecords.isNotEmpty, true);
      expect(viewModel.netWorthRecords.first.netWorth, 15000.0);
    });

    // Add more tests to cover scenarios like updating net worth records,
    // handling empty states, and error handling.
  });
}
