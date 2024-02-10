import 'package:flutter_test/flutter_test.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  group('DatabaseService Test', () {
    late DatabaseService databaseService;
    late Isar isar;

    setUp(() async {
      // Initialize Isar for testing
      final dir = await getTemporaryDirectory();
      isar = await Isar.open(
        [AccountSchema],
        directory: dir.path,
        name: 'test',
      );

      databaseService = DatabaseService();
      // Override the isar instance in your service with the test instance
      databaseService.isar = isar;
    });

    tearDown(() async {
      // Close the Isar instance and delete the database after each test
      await isar.close();
    });

    test('Add and Retrieve Account', () async {
      final account = Account()
        ..accountId = '12345'
        ..accountName = 'Test Account'
        ..accountType = 'checking'
        ..balance = 1000.0;

      await databaseService.addAccount(account);

      final accounts = await databaseService.getAllAccounts();
      expect(accounts.isNotEmpty, true);
      final retrievedAccount = accounts.first;
      expect(retrievedAccount.accountId, '12345');
      expect(retrievedAccount.accountName, 'Test Account');
      expect(retrievedAccount.accountType, 'checking');
      expect(retrievedAccount.balance, 1000.0);
    });

    // Additional tests for update, delete operations, and other models can follow a similar structure
  });
}
