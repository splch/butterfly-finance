import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/net_worth.dart';
import 'package:butterfly_finance/view_models/net_worth_view_model.dart';

void main() {
  late DatabaseService databaseService;
  late Isar isar;

  setUp(() async {
    // Initialize the Isar instance
    await Isar.initializeIsarCore(download: true);

    final directory = Directory.systemTemp.createTempSync();

    isar = await Isar.open(
      [NetWorthSchema],
      directory: directory.path,
    );

    // Initialize the database service with the mock Isar instance
    databaseService = DatabaseService();
    databaseService.isar = isar;
  });

  tearDown(() async {
    await databaseService.closeDatabase(deleteFromDisk: true);
  });

  group('NetWorthViewModel Tests', () {
    late NetWorthViewModel netWorthViewModel;

    setUp(() {
      // Initialize the NetWorthViewModel with the DatabaseService
      netWorthViewModel = NetWorthViewModel(databaseService);
    });

    test('Add and Retrieve Net Worth', () async {
      final testNetWorth = NetWorth()
        ..date = DateTime.now()
        ..totalAssets = 10000.0
        ..totalLiabilities = 5000.0;

      await netWorthViewModel.addNetWorth(testNetWorth);
      final netWorthRecords = await netWorthViewModel.getAllNetWorthRecords();
      expect(netWorthRecords.isNotEmpty, true);
      expect(netWorthRecords.first.netWorth, equals(5000.0));
    });
  });
}
