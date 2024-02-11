import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:butterfly_finance/services/database_service.dart';
import 'package:butterfly_finance/models/account.dart';
import 'package:butterfly_finance/models/budget.dart';
import 'package:butterfly_finance/models/net_worth.dart';
import 'package:butterfly_finance/models/transaction.dart';

class MLService {
  final DatabaseService _databaseService;

  MLService(this._databaseService);

  // Method to predict future net worth based on past total assets and liabilities
  Future<double> predictNetWorth(DateTime predictionDate) async {
    final netWorthRecords = await _databaseService.getAllNetWorthRecords();
    final netWorthRecordDataFrame = DataFrame(
        netWorthRecords
            .where((record) => record.date.isBefore(predictionDate))
            .map((record) => [
                  record.date.millisecondsSinceEpoch.toDouble(),
                  record.totalAssets,
                  record.totalLiabilities,
                ]),
        headerExists: false,
        header: ['date', 'totalAssets', 'totalLiabilities']);

    // Using a linear regressor to predict total assets
    final assetRegressor = LinearRegressor(
        netWorthRecordDataFrame
            .sampleFromSeries(names: ['date', 'totalAssets']),
        'totalAssets');

    // Using a linear regressor to predict total liabilities
    final liabilityRegressor = LinearRegressor(
        netWorthRecordDataFrame
            .sampleFromSeries(names: ['date', 'totalLiabilities']),
        'totalLiabilities');

    // Predicting future total assets
    final predictedTotalAssets = assetRegressor.predict(DataFrame(
        [
          [predictionDate.millisecondsSinceEpoch.toDouble()]
        ],
        headerExists: false,
        header: ['date']));

    // Predicting future total liabilities
    final predictedTotalLiabilities = liabilityRegressor.predict(DataFrame(
        [
          [predictionDate.millisecondsSinceEpoch.toDouble()]
        ],
        headerExists: false,
        header: ['date']));

    return predictedTotalAssets.rows.first.first -
        predictedTotalLiabilities.rows.first.first;
  }

  // Method to predict total monthly expenses based on past records
  Future<double> predictMonthlyExpenses(DateTime predictionDate) async {
    final transactions = await _databaseService.getTransactionsBetweenDates(
        DateTime(DateTime.now().year, DateTime.now().month, 1), predictionDate);
    // Convert Transactions to DataFrame
    DataFrame transactionsDataFrame = DataFrame(
        transactions
            .where((transaction) => transaction.amount < 0)
            .map((transaction) => [
                  transaction.date.millisecondsSinceEpoch.toDouble(),
                  transaction.amount,
                ]),
        headerExists: false,
        header: ['date', 'amount']);

    // Modify the amount column to be a running total
    transactionsDataFrame =
        _transformAmountToRunningTotal(transactionsDataFrame, 'amount');

    // Using a linear regressor to predict future monthly expenses
    final regressor = LinearRegressor(transactionsDataFrame, 'amount');

    // Predicting future monthly expenses
    final predictedMonthlyExpenses = regressor.predict(DataFrame(
        [
          [predictionDate.millisecondsSinceEpoch.toDouble()]
        ],
        headerExists: false,
        header: ['date']));

    return predictedMonthlyExpenses.rows.first.first;
  }

  // Method to predict if an account is at risk of going negative
  Future<bool> predictAccountRisk(Account account) async {
    final transactions = await _databaseService.getAllTransactions();
    // Convert Transactions to DataFrame
    DataFrame transactionsDataFrame = DataFrame(
        transactions
            .where((transaction) => transaction.accountId == account.accountId)
            .where((transaction) => transaction.date.isAfter(
                DateTime(DateTime.now().year, DateTime.now().month, 1)))
            .where((transaction) => transaction.date.isBefore(
                DateTime(DateTime.now().year, DateTime.now().month + 1, 1)))
            .map((transaction) => [
                  transaction.date.millisecondsSinceEpoch.toDouble(),
                  transaction.amount,
                ]),
        headerExists: false,
        header: ['date', 'amount']);

    // Modify the amount column to be a running total
    transactionsDataFrame =
        _transformAmountToRunningTotal(transactionsDataFrame, 'amount');

    // Using a linear regressor to predict if an account is at risk of going negative
    final regressor = LinearRegressor(transactionsDataFrame, 'amount');

    // Predicting if an account is at risk of going negative
    final prediction = regressor.predict(DataFrame(
        [
          [DateTime.now().millisecondsSinceEpoch.toDouble()]
        ],
        headerExists: false,
        header: ['date']));

    return account.balance + prediction.rows.first.first < 0;
  }

  // Method to predict if a budget will be exceeded
  Future<bool> predictBudgetExceeded(Budget budget) async {
    final transactions = await _databaseService.getTransactionsBetweenDates(
        DateTime(DateTime.now().year, DateTime.now().month, 1),
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1));
    // Convert Transactions to DataFrame
    DataFrame transactionsDataFrame = DataFrame(
        transactions
            .where((transaction) => transaction.category == budget.category)
            .map((transaction) => [
                  transaction.date.millisecondsSinceEpoch.toDouble(),
                  transaction.amount,
                ]),
        headerExists: false,
        header: ['date', 'amount']);

    // Modify the amount column to be a running total
    transactionsDataFrame =
        _transformAmountToRunningTotal(transactionsDataFrame, 'amount');

    // Using a linear regressor to predict if a budget will be exceeded
    final regressor = LinearRegressor(transactionsDataFrame, 'amount');

    // Predicting if a budget will be exceeded
    final prediction = regressor.predict(DataFrame(
        [
          [
            DateTime(DateTime.now().year, DateTime.now().month + 1, 1)
                .millisecondsSinceEpoch
                .toDouble()
          ]
        ],
        headerExists: false,
        header: ['date']));

    print(-prediction.rows.first.first);

    return -prediction.rows.first.first > budget.amount;
  }

  // Method to predict if a net worth record exceeds the expected value
  Future<bool> predictNetWorthExceeded(NetWorth netWorth) async {
    final netWorthRecords = await _databaseService.getAllNetWorthRecords();
    // Convert NetWorth records to DataFrame
    final netWorthDataFrame = DataFrame(
        netWorthRecords
            .where((record) => record.date.isBefore(netWorth.date))
            .map((record) => [
                  record.date.millisecondsSinceEpoch.toDouble(),
                  record.netWorth,
                ]),
        headerExists: false,
        header: ['date', 'netWorth']);

    // Using a linear regressor to predict if a net worth record exceeds the expected value
    final regressor = LinearRegressor(netWorthDataFrame, 'netWorth');

    // Predicting if a net worth record exceeds the expected value
    final prediction = regressor.predict(DataFrame(
        [
          [netWorth.date.millisecondsSinceEpoch.toDouble()]
        ],
        headerExists: false,
        header: ['date']));

    return prediction.rows.first.first > netWorth.netWorth;
  }

  // Method to predict if a transaction is fraudulent
  Future<bool> predictFraudulentTransaction(Transaction transaction) async {
    return false;
  }

  DataFrame _transformAmountToRunningTotal(
      DataFrame inputDataFrame, String columnName) {
    // Extract the 'amount' column data
    final amounts = inputDataFrame[columnName].data;
    var runningTotal = 0.0;

    // Calculate the running totals
    final runningTotals = amounts.map((value) {
      runningTotal += value as double;
      return runningTotal;
    }).toList();

    // Create a new Series with the running totals
    final runningTotalSeries = Series(columnName, runningTotals);

    // Drop the old 'amount' series from the DataFrame
    final tempDataFrame = inputDataFrame.dropSeries(names: [columnName]);

    // Add the new runningTotalSeries to the DataFrame
    final updatedDataFrame = tempDataFrame.addSeries(runningTotalSeries);

    return updatedDataFrame;
  }
}
