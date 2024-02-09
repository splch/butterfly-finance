import 'package:hive/hive.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/models/budget.dart';
import 'package:butterfly_finance/models/net_worth.dart';
import 'package:butterfly_finance/models/transaction.dart';

class DatabaseService {
  late Box<Account> _accountBox;
  late Box<Budget> _budgetBox;
  late Box<NetWorth> _netWorthBox;
  late Box<Transaction> _transactionBox;

  DatabaseService() {
    _initialize();
  }

  Future<void> _initialize() async {
    // Assuming adapters are registered elsewhere or before this method is called
    _accountBox = await Hive.openBox<Account>('accounts');
    _budgetBox = await Hive.openBox<Budget>('budgets');
    _netWorthBox = await Hive.openBox<NetWorth>('netWorths');
    _transactionBox = await Hive.openBox<Transaction>('transactions');
  }

  // Account CRUD Operations
  Future<String> insertAccount(Account account) async {
    await _accountBox.put(account.accountId, account);
    return account.accountId;
  }

  Future<Account?> getAccount(String accountId) async {
    return _accountBox.get(accountId);
  }

  Future<void> updateAccount(Account account) async {
    await _accountBox.put(account.accountId, account);
  }

  Future<void> deleteAccount(String accountId) async {
    await _accountBox.delete(accountId);
  }

  // Budget CRUD Operations
  Future<String> insertBudget(Budget budget) async {
    await _budgetBox.put(budget.budgetId, budget);
    return budget.budgetId;
  }

  Future<Budget?> getBudget(String budgetId) async {
    return _budgetBox.get(budgetId);
  }

  Future<void> updateBudget(Budget budget) async {
    await _budgetBox.put(budget.budgetId, budget);
  }

  Future<void> deleteBudget(String budgetId) async {
    await _budgetBox.delete(budgetId);
  }

  // Net Worth CRUD Operations
  Future<String> insertNetWorth(NetWorth netWorth) async {
    await _netWorthBox.put(netWorth.recordId, netWorth);
    return netWorth.recordId;
  }

  Future<NetWorth?> getNetWorth(String recordId) async {
    return _netWorthBox.get(recordId);
  }

  Future<void> updateNetWorth(NetWorth netWorth) async {
    await _netWorthBox.put(netWorth.recordId, netWorth);
  }

  Future<void> deleteNetWorth(String recordId) async {
    await _netWorthBox.delete(recordId);
  }

  // Transaction CRUD Operations
  Future<String> insertTransaction(Transaction transaction) async {
    await _transactionBox.put(transaction.transactionId, transaction);
    return transaction.transactionId;
  }

  Future<Transaction?> getTransaction(String transactionId) async {
    return _transactionBox.get(transactionId);
  }

  Future<void> updateTransaction(Transaction transaction) async {
    await _transactionBox.put(transaction.transactionId, transaction);
  }

  Future<void> deleteTransaction(String transactionId) async {
    await _transactionBox.delete(transactionId);
  }

  // Fetch all Accounts
  Future<List<Account>> getAllAccounts() async {
    final accounts = _accountBox.values.toList();
    return accounts;
  }

  // Fetch all Budgets
  Future<List<Budget>> getAllBudgets() async {
    final budgets = _budgetBox.values.toList();
    return budgets;
  }

  // Fetch all Net Worth Records
  Future<List<NetWorth>> getAllNetWorthRecords() async {
    final netWorthRecords = _netWorthBox.values.toList();
    return netWorthRecords;
  }

  // Fetch all Transactions
  Future<List<Transaction>> getAllTransactions() async {
    final transactions = _transactionBox.values.toList();
    return transactions;
  }
}
