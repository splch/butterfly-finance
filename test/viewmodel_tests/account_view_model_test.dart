import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/view_models/account_view_model.dart';

void main() {
  late DatabaseService databaseService;
  late Isar isar;

  setUp(() async {
    // Initialize the Isar instance
    await Isar.initializeIsarCore(download: true);

    final directory = Directory.systemTemp.createTempSync();

    isar = await Isar.open(
      [AccountSchema],
      directory: directory.path,
    );

    // Initialize the database service with the mock Isar instance
    databaseService = DatabaseService();
    databaseService.isar = isar;
  });

  tearDown(() async {
    await databaseService.closeDatabase(deleteFromDisk: true);
  });

  group('AccountViewModel Tests', () {
    late AccountViewModel accountViewModel;

    setUp(() {
      // Initialize the AccountViewModel with the DatabaseService
      accountViewModel = AccountViewModel(databaseService);
    });

    test('Add and Retrieve Account', () async {
      final testAccount = Account()
        ..accountId = 'testId'
        ..accountName = 'Test Account'
        ..accountType = 'Savings'
        ..balance = 1000.0
        ..plaidAccessToken = '123'
        ..plaidItemId = '456';

      await accountViewModel.addAccount(testAccount);
      final accounts = await accountViewModel.getAllAccounts();
      expect(accounts.isNotEmpty, true);
      expect(accounts.first.accountName, equals('Test Account'));
    });
  });
}
