# Butterfly Finance

Butterfly Finance is a personal finance application designed to help users manage their finances more efficiently. Developed with Flutter and leveraging Plaid for secure financial data integration, Butterfly Finance offers a range of features including bank account linking, transaction history, spending analysis, category-based budgeting, and net worth tracking — all within a standalone, user-friendly environment.

![Butterfly Finance](https://github.com/splch/butterfly-finance/assets/25377399/c991ef61-c716-4596-8546-162d0fa3e18b)

## Features

- **Bank Account Linking**: Securely link your bank accounts using Plaid.
- **Transaction History**: View all your financial transactions in one place.
- **Spending Analysis**: Analyze your spending patterns to make informed financial decisions.
- **Budgeting**: Set and manage budgets by category to stay on track with your financial goals.
- **Net Worth Tracking**: Keep track of your net worth over time.

## Getting Started

### Prerequisites

- Flutter (latest version)
- Dart (latest version)
- An IDE (Visual Studio Code, Android Studio, etc.)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/splch/butterfly_finance.git
```

2. Navigate to the project directory:

```bash
cd butterfly_finance
```

3. Install dependencies:

```bash
flutter pub get
```

4. Build the project:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

5. Run the app (optional, run tests first):

```bash
flutter test
flutter run
```

## Development

This project is developed using the following technology stack:

- **[Flutter](https://flutter.dev/)**: For creating a cross-platform mobile application.
- **[Plaid](https://plaid.com/)**: For secure bank account linking and financial data aggregation.
- **[isar](https://isar.dev/)**: For local database storage.
- **[fl_chart](https://app.flchart.dev/#/line)**: For generating charts and graphs.
- **[ml_algo](https://www.ml-algo.com/)**: For machine learning predictions.

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.
