import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/models/transaction.dart';
import 'package:butterfly_finance/models/budget.dart';
import 'package:butterfly_finance/models/net_worth.dart';

class DatabaseService {
  late Box<Account> accounts;
  late Box<Transaction> transactions;
  late Box<Budget> budgets;
  late Box<NetWorth> netWorths;

  Future<void> initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.defaultDirectory = dir.path;

    accounts = Hive.box<Account>(name: 'accounts');
    transactions = Hive.box<Transaction>(name: 'transactions');
    budgets = Hive.box<Budget>(name: 'budgets');
    netWorths = Hive.box<NetWorth>(name: 'netWorths');
  }

  // CRUD operations for Account
  void addAccount(Account account) async {
    return accounts.add(account);
  }

  Account? getAccount(String key) {
    return accounts.get(key);
  }

  List<Account?> getAllAccounts() {
    return accounts.getRange(0, accounts.length);
  }

  void updateAccount(String key, Account updatedAccount) {
    return accounts.put(key, updatedAccount);
  }

  void deleteAccount(String key) {
    accounts.delete(key);
  }

  // CRUD operations for Transaction
  void addTransaction(Transaction transaction) async {
    return transactions.add(transaction);
  }

  Transaction? getTransaction(String key) {
    return transactions.get(key);
  }

  List<Transaction?> getAllTransactions() {
    return transactions.getRange(0, transactions.length);
  }

  void updateTransaction(String key, Transaction updatedTransaction) {
    return transactions.put(key, updatedTransaction);
  }

  void deleteTransaction(String key) {
    transactions.delete(key);
  }

  // CRUD operations for Budget
  void addBudget(Budget budget) async {
    return budgets.add(budget);
  }

  Budget? getBudget(String key) {
    return budgets.get(key);
  }

  List<Budget?> getAllBudgets() {
    return budgets.getRange(0, budgets.length);
  }

  void updateBudget(String key, Budget updatedBudget) {
    return budgets.put(key, updatedBudget);
  }

  void deleteBudget(String key) {
    budgets.delete(key);
  }

  // CRUD operations for NetWorth
  void addNetWorth(NetWorth netWorth) async {
    return netWorths.add(netWorth);
  }

  NetWorth? getNetWorth(String key) {
    return netWorths.get(key);
  }

  List<NetWorth?> getAllNetWorths() {
    return netWorths.getRange(0, netWorths.length);
  }

  void updateNetWorth(String key, NetWorth updatedNetWorth) {
    return netWorths.put(key, updatedNetWorth);
  }

  void deleteNetWorth(String key) {
    netWorths.delete(key);
  }

  // Don't forget to close boxes when they are no longer needed
  void closeBoxes() {
    accounts.close();
    transactions.close();
    budgets.close();
    netWorths.close();
  }
}
