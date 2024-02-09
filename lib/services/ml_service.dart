import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';

abstract class MLService {
  Future<void> trainNetWorthModel(DataFrame trainingData, String targetColumn);
  Future<DataFrame> predictNetWorth(DataFrame netWorthData);
  Future<void> trainSpendingModel(DataFrame trainingData, String targetColumn);
  Future<bool> willExceedBudget(DataFrame budgetData, double budgetAmount);
}

class MLServiceImpl implements MLService {
  late LinearRegressor _netWorthModel;
  late LinearRegressor _spendingModel;
  bool _isSpendingModelTrained = false;
  bool _isNetWorthModelTrained = false;

  @override
  Future<void> trainNetWorthModel(
      DataFrame trainingData, String targetColumn) async {
    if (!trainingData.header.contains(targetColumn)) {
      throw Exception(
          'Target column $targetColumn not found in training data.');
    }
    _netWorthModel = LinearRegressor(trainingData, targetColumn);
    _isNetWorthModelTrained = true;
  }

  @override
  Future<DataFrame> predictNetWorth(DataFrame netWorthData) async {
    if (!_isNetWorthModelTrained) {
      throw Exception(
          'Model has not been trained. Please call trainNetWorthModel first.');
    }
    final predictions = _netWorthModel.predict(netWorthData);
    return predictions;
  }

  @override
  Future<void> trainSpendingModel(
      DataFrame trainingData, String targetColumn) async {
    if (!trainingData.header.contains(targetColumn)) {
      throw Exception(
          'Target column $targetColumn not found in training data.');
    }
    _spendingModel = LinearRegressor(trainingData, targetColumn);
    _isSpendingModelTrained = true;
  }

  @override
  Future<bool> willExceedBudget(
      DataFrame budgetData, double budgetAmount) async {
    if (!_isSpendingModelTrained) {
      throw Exception(
          'Spending model has not been trained. Please train the model first.');
    }
    final predictions = _spendingModel.predict(budgetData);
    double totalPredictedSpending =
        predictions.rows.fold(0, (sum, row) => sum + row.first);
    return totalPredictedSpending > budgetAmount;
  }
}
