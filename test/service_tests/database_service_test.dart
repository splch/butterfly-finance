import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/models/budget.dart';
import 'package:butterfly_finance/models/net_worth.dart';
import 'package:butterfly_finance/models/transaction.dart';
import 'package:butterfly_finance/models/user.dart';

void main() {
  late DatabaseService databaseService;
  late Isar isar;
  final date = DateTime.now();

  setUp(() async {
    final directory = Directory.systemTemp.createTempSync();

    isar = await Isar.open(
      [
        AccountSchema,
        BudgetSchema,
        NetWorthSchema,
        TransactionSchema,
        UserSchema
      ],
      directory: directory.path,
    );

    // Initialize the database service with the mock Isar instance
    databaseService = DatabaseService();
    databaseService.isar = isar;
  });

  tearDown(() async {
    await databaseService.closeDatabase(deleteFromDisk: true);
  });

  group('Account CRUD Operations', () {
    final testAccount = Account()
      ..accountId = '123'
      ..accountName = 'Test Account'
      ..accountType = 'Checking'
      ..balance = 100.0
      ..plaidAccessToken = '123'
      ..plaidItemId = '456';

    test('Create an Account', () async {
      await databaseService.addAccount(testAccount);

      final accounts = await databaseService.getAllAccounts();
      expect(accounts.isNotEmpty, true);
      expect(accounts.first.accountName, testAccount.accountName);
    });

    test('Read an Account', () async {
      // Assuming addAccount returns the ID of the newly added account, which is missing in your original code
      final int accountId = await databaseService.addAccount(testAccount);
      final account = await databaseService
          .getAccount(accountId); // Adjust to use the returned ID
      expect(account, isNotNull);
      expect(account!.accountName, testAccount.accountName);
    });

    test('Update an Account', () async {
      final int accountId = await databaseService.addAccount(testAccount);
      testAccount.id =
          accountId; // Make sure to set the ID on the testAccount object
      testAccount.balance = 200.0; // Change a field
      await databaseService.updateAccount(testAccount);

      final updatedAccount = await databaseService.getAccount(accountId);
      expect(updatedAccount, isNotNull);
      expect(updatedAccount!.balance, 200.0);
    });

    test('Delete an Account', () async {
      final int accountId = await databaseService.addAccount(testAccount);
      await databaseService.deleteAccount(accountId);
      final account = await databaseService.getAccount(accountId);
      expect(account, isNull);
    });
  });

  group('Budget CRUD Operations', () {
    final testBudget = Budget()
      ..category = 'Groceries'
      ..amount = 100.0;

    test('Create a Budget', () async {
      await databaseService.addBudget(testBudget);

      final budgets = await databaseService.getAllBudgets();
      expect(budgets.isNotEmpty, true);
      expect(budgets.first.category, testBudget.category);
      expect(budgets.first.amount, testBudget.amount);
    });

    test('Read a Budget', () async {
      // Assuming addBudget returns the ID of the newly added budget, which is missing in your original code
      final int budgetId = await databaseService.addBudget(testBudget);
      final budget = await databaseService
          .getBudget(budgetId); // Adjust to use the returned ID
      expect(budget, isNotNull);
      expect(budget!.amount, testBudget.amount);
    });

    test('Update a Budget', () async {
      final int budgetId = await databaseService.addBudget(testBudget);
      testBudget.id =
          budgetId; // Make sure to set the ID on the testBudget object
      testBudget.amount = 200.0; // Change a field
      await databaseService.updateBudget(testBudget);

      final updatedBudget = await databaseService.getBudget(budgetId);
      expect(updatedBudget, isNotNull);
      expect(updatedBudget!.amount, 200.0);
    });

    test('Delete a Budget', () async {
      final int budgetId = await databaseService.addBudget(testBudget);
      await databaseService.deleteBudget(budgetId);
      final budget = await databaseService.getBudget(budgetId);
      expect(budget, isNull);
    });
  });

  group('Net Worth CRUD Operations', () {
    final testNetWorth = NetWorth()
      ..date = DateTime.now()
      ..totalAssets = 100.0
      ..totalLiabilities = 50.0;

    test('Create a Net Worth', () async {
      await databaseService.addNetWorth(testNetWorth);

      final netWorths = await databaseService.getAllNetWorthRecords();
      expect(netWorths.isNotEmpty, true);
      expect(netWorths.first.totalAssets, testNetWorth.totalAssets);
      expect(netWorths.first.totalLiabilities, testNetWorth.totalLiabilities);
    });

    test('Read a Net Worth', () async {
      // Assuming addNetWorth returns the ID of the newly added net worth, which is missing in your original code
      final int netWorthId = await databaseService.addNetWorth(testNetWorth);
      final netWorth = await databaseService
          .getNetWorth(netWorthId); // Adjust to use the returned ID
      expect(netWorth, isNotNull);
      expect(netWorth!.netWorth, testNetWorth.netWorth);
    });

    test('Update a Net Worth', () async {
      final int netWorthId = await databaseService.addNetWorth(testNetWorth);
      testNetWorth.id =
          netWorthId; // Make sure to set the ID on the testNetWorth object
      testNetWorth.totalAssets =
          testNetWorth.totalLiabilities; // Change a field
      await databaseService.updateNetWorth(testNetWorth);

      final updatedNetWorth = await databaseService.getNetWorth(netWorthId);
      expect(updatedNetWorth, isNotNull);
      expect(updatedNetWorth!.netWorth, 0.0);
    });

    test('Delete a Net Worth', () async {
      final int netWorthId = await databaseService.addNetWorth(testNetWorth);
      await databaseService.deleteNetWorth(netWorthId);
      final netWorth = await databaseService.getNetWorth(netWorthId);
      expect(netWorth, isNull);
    });
  });

  group('Transaction CRUD Operations', () {
    final testTransaction = Transaction()
      ..transactionId = '123'
      ..accountId = '456'
      ..date = date
      ..amount = 100.0
      ..category = 'Groceries'
      ..description = 'Grocery shopping';

    test('Create a Transaction', () async {
      await databaseService.addTransaction(testTransaction);

      final transactions = await databaseService.getAllTransactions();
      expect(transactions.isNotEmpty, true);
      expect(transactions.first.transactionId, testTransaction.transactionId);
      expect(transactions.first.accountId, testTransaction.accountId);
      expect(transactions.first.amount, testTransaction.amount);
      expect(transactions.first.category, testTransaction.category);
      expect(transactions.first.description, testTransaction.description);
    });

    test('Read a Transaction', () async {
      // Assuming addTransaction returns the ID of the newly added transaction, which is missing in your original code
      final int transactionId =
          await databaseService.addTransaction(testTransaction);
      final transaction = await databaseService
          .getTransaction(transactionId); // Adjust to use the returned ID
      expect(transaction, isNotNull);
      expect(transaction!.amount, testTransaction.amount);
    });

    test('Get Monthly Transactions', () async {
      await databaseService.addTransaction(testTransaction);

      final monthlyTransactions =
          await databaseService.getTransactionsBetweenDates(
        DateTime(date.year, date.month, 1),
        DateTime(date.year, date.month + 1, 0),
      );
      expect(monthlyTransactions.isNotEmpty, true);
    });

    test('Update a Transaction', () async {
      final int transactionId =
          await databaseService.addTransaction(testTransaction);
      testTransaction.id =
          transactionId; // Make sure to set the ID on the testTransaction object
      testTransaction.amount = 200.0; // Change a field
      await databaseService.updateTransaction(testTransaction);

      final updatedTransaction =
          await databaseService.getTransaction(transactionId);
      expect(updatedTransaction, isNotNull);
      expect(updatedTransaction!.amount, 200.0);
    });

    test('Delete a Transaction', () async {
      final int transactionId =
          await databaseService.addTransaction(testTransaction);
      await databaseService.deleteTransaction(transactionId);
      final transaction = await databaseService.getTransaction(transactionId);
      expect(transaction, isNull);
    });
  });

  group('User CRUD Operations', () {
    final testUser = User()
      ..email = 'user@example.com'
      ..name = 'Test User'
      ..plaidClientId = '123'
      ..plaidSecret = '456';

    test('Create a User', () async {
      await databaseService.addUser(testUser);

      final users = await databaseService.getAllUsers();
      expect(users.isNotEmpty, true);
      expect(users.first.email, testUser.email);
      expect(users.first.name, testUser.name);
      expect(users.first.plaidClientId, testUser.plaidClientId);
      expect(users.first.plaidSecret, testUser.plaidSecret);
    });

    test('Read a User', () async {
      final int userId = await databaseService.addUser(testUser);
      final user = await databaseService.getUser(testUser.email);
      expect(user, isNotNull);
      expect(user!.email, testUser.email);
    });

    test('Update a User', () async {
      final int userId = await databaseService.addUser(testUser);
      testUser.id = userId;
      testUser.name = 'Updated User'; // Change a field
      await databaseService.updateUser(testUser);

      final updatedUser = await databaseService.getUser(testUser.email);
      expect(updatedUser, isNotNull);
      expect(updatedUser!.name, 'Updated User');
    });

    test('Delete a User', () async {
      final int userId = await databaseService.addUser(testUser);
      await databaseService.deleteUser(testUser.email);
      final user = await databaseService.getUser(testUser.email);
      expect(user, isNull);
    });

    test('Get Plaid Keys', () async {
      final int userId = await databaseService.addUser(testUser);
      final plaidKeys = await databaseService.getPlaidKeys(testUser.email);
      expect(plaidKeys.isNotEmpty, true);
      expect(plaidKeys['clientId'], testUser.plaidClientId);
      expect(plaidKeys['secret'], testUser.plaidSecret);
    });
  });
}
