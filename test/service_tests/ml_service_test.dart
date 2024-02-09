import 'package:flutter_test/flutter_test.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:butterfly_finance/services/ml_service.dart';

void main() {
  group('Net Worth Prediction Tests', () {
    late MLServiceImpl mlService;
    late DataFrame trainingData;
    late DataFrame netWorthData;

    setUp(() {
      mlService = MLServiceImpl();

      // Simulate training data with features and net worth as target
      trainingData = DataFrame([
        ['MonthlyIncome', 'MonthlyExpenses', 'NetWorth'],
        [5000, 3000, 2000],
        [6000, 3000, 3000],
        [7000, 4000, 3000],
      ]);

      // Simulate data for net worth prediction
      netWorthData = DataFrame([
        [6500, 3500],
      ], header: [
        'MonthlyIncome',
        'MonthlyExpenses'
      ], headerExists: false);
    });

    test('Net worth model training and prediction', () async {
      await mlService.trainNetWorthModel(trainingData, 'NetWorth');

      // Predict net worth based on new data
      DataFrame prediction = await mlService.predictNetWorth(netWorthData);

      // Assuming the model is simplistic and the data is perfectly linear,
      // we can expect some predicted value. In real tests, you'd check the shape of the prediction
      // and possibly the range of the predicted values rather than exact matches due to the nature of ML predictions.
      expect(prediction.rows.isNotEmpty, true);
      expect(prediction.rows.first.isNotEmpty, true);
      // This is a very basic check. In a real scenario, you'd have specific expectations.
    });
  });

  group('Spending Model Budget Prediction Tests', () {
    late MLServiceImpl mlService;
    late DataFrame trainingData;
    late DataFrame budgetData;

    setUp(() {
      mlService = MLServiceImpl();

      // Simulate training data with features indicating spending patterns
      trainingData = DataFrame([
        [1, 1200], // [Month, Spending]
        [2, 1500],
        [3, 1800],
        [4, 2000],
      ], header: [
        'Month',
        'Spending'
      ], headerExists: false);

      // Simulate prediction data for a future month
      // Note: The 'Month' feature here is just a placeholder and not used directly for prediction in this context
      budgetData = DataFrame([
        [
          5
        ], // Assuming it's the 5th month and we want to predict if spending will exceed a certain budget
      ], header: [
        'Month'
      ], headerExists: false);
    });

    test(
        'trainSpendingModel and willExceedBudget predict budget exceedance correctly',
        () async {
      await mlService.trainSpendingModel(trainingData, 'Spending');

      // Example budget that we want to check against
      const budgetThreshold = 1700.0;

      // Predict if future spending will exceed the budget
      bool exceedsBudget =
          await mlService.willExceedBudget(budgetData, budgetThreshold);

      // Expect the prediction to indicate that the budget will be exceeded
      // The expectation here assumes the model will predict spending based on past trends accurately
      expect(exceedsBudget, true);
    });
  });
}
