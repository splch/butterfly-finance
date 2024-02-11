import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/models/transaction.dart';
import 'package:butterfly_finance/models/budget.dart';
import 'package:butterfly_finance/models/net_worth.dart';

class DatabaseService {
  late final Isar isar;

  Future<void> initializeDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [AccountSchema, TransactionSchema, BudgetSchema, NetWorthSchema],
      directory: dir.path,
    );
  }

  // Close the database
  Future<void> closeDatabase({bool deleteFromDisk = false}) async {
    await isar.close(deleteFromDisk: deleteFromDisk);
  }

  // Account operations
  Future<int> addAccount(Account account) async {
    return await isar.writeTxn(() => isar.accounts.put(account));
  }

  Future<List<Account>> getAllAccounts() async {
    return isar.accounts.where().findAll();
  }

  Future<Account?> getAccount(int id) async {
    return isar.accounts.get(id);
  }

  Future<void> updateAccount(Account account) async {
    await isar.writeTxn(() async {
      await isar.accounts.put(account);
    });
  }

  Future<void> deleteAccount(int id) async {
    await isar.writeTxn(() => isar.accounts.delete(id));
  }

  // Transaction operations
  Future<int> addTransaction(Transaction transaction) async {
    return await isar.writeTxn(() => isar.transactions.put(transaction));
  }

  Future<List<Transaction>> getAllTransactions() async {
    return isar.transactions.where().findAll();
  }

  Future<List<Transaction>> getTransactionsBetweenDates(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return isar.transactions
        .where()
        .filter()
        .dateBetween(startDate, endDate)
        .findAll();
  }

  Future<Transaction?> getTransaction(int id) async {
    return isar.transactions.get(id);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await isar.writeTxn(() async {
      await isar.transactions.put(transaction);
    });
  }

  Future<void> deleteTransaction(int id) async {
    await isar.writeTxn(() => isar.transactions.delete(id));
  }

  // Budget operations
  Future<int> addBudget(Budget budget) async {
    return await isar.writeTxn(() => isar.budgets.put(budget));
  }

  Future<List<Budget>> getAllBudgets() async {
    return isar.budgets.where().findAll();
  }

  Future<Budget?> getBudget(int id) async {
    return isar.budgets.get(id);
  }

  Future<void> updateBudget(Budget budget) async {
    await isar.writeTxn(() async {
      await isar.budgets.put(budget);
    });
  }

  Future<void> deleteBudget(int id) async {
    await isar.writeTxn(() => isar.budgets.delete(id));
  }

  // Net Worth operations
  Future<int> addNetWorth(NetWorth netWorth) async {
    return await isar.writeTxn(() => isar.netWorths.put(netWorth));
  }

  Future<List<NetWorth>> getAllNetWorthRecords() async {
    return isar.netWorths.where().findAll();
  }

  Future<NetWorth?> getNetWorth(int id) async {
    return isar.netWorths.get(id);
  }

  Future<void> updateNetWorth(NetWorth netWorth) async {
    await isar.writeTxn(() async {
      await isar.netWorths.put(netWorth);
    });
  }

  Future<void> deleteNetWorth(int id) async {
    await isar.writeTxn(() => isar.netWorths.delete(id));
  }

  // Most recent net worth
  Future<NetWorth?> getMostRecentNetWorth() async {
    return isar.netWorths.where().sortByDate().findFirst();
  }

  // The net worths after a certain date
  Future<List<NetWorth>> getNetWorthsAfterDate(DateTime startDate) async {
    return isar.netWorths.where().filter().dateGreaterThan(startDate).findAll();
  }

  // The amount spent in each budget category for a given date range
  Future<Map<String, double>> getBudgetCategorySpending(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactions = await isar.transactions
        .where()
        .filter()
        .dateBetween(startDate, endDate)
        .findAll();

    final categorySpending = <String, double>{};
    for (final transaction in transactions) {
      if (categorySpending.containsKey(transaction.category)) {
        categorySpending[transaction.category] =
            categorySpending[transaction.category]! + transaction.amount;
      } else {
        categorySpending[transaction.category] = transaction.amount;
      }
    }

    return categorySpending;
  }

  // The most recent n transactions
  Future<List<Transaction>> getRecentTransactions(int n) async {
    return isar.transactions.where().sortByDate().limit(n).findAll();
  }

  // Average spending by month
  Future<Map<int, double>> getAverageSpendingByMonth() async {
    final transactions = await isar.transactions.where().findAll();

    final averageSpendingByMonth = <int, double>{};
    for (final transaction in transactions) {
      averageSpendingByMonth.update(
        transaction.date.month,
        (value) => (value + transaction.amount) / 2,
        ifAbsent: () => transaction.amount,
      );
    }

    return averageSpendingByMonth;
  }

  // The average spending by category
  Future<Map<String, double>> getAverageSpendingByCategory() async {
    final transactions = await isar.transactions.where().findAll();

    final averageSpendingByCategory = <String, double>{};
    for (final transaction in transactions) {
      averageSpendingByCategory.update(
        transaction.category,
        (value) => (value + transaction.amount) / 2,
        ifAbsent: () => transaction.amount,
      );
    }

    return averageSpendingByCategory;
  }

  // The daily total spending after a certain date
  Future<Map<DateTime, double>> getDailyTotalSpending(
      DateTime startDate) async {
    final transactions = await isar.transactions
        .where()
        .filter()
        .dateGreaterThan(startDate)
        .findAll();

    final dailyTotalSpending = <DateTime, double>{};
    for (final transaction in transactions) {
      dailyTotalSpending.update(
        transaction.date,
        (value) => value + transaction.amount,
        ifAbsent: () => transaction.amount,
      );
    }

    return dailyTotalSpending;
  }
}
