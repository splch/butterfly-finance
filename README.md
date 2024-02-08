# Butterfly Finance

This Flutter app is designed to help users manage their personal finances by linking their bank accounts through Plaid, tracking transactions, analyzing spending, managing category budgets, and tracking net worth over time.

## Features

- **Account Linking:** Securely link bank accounts using Plaid.
- **Transaction History:** View and manage transaction records.
- **Spending Analysis:** Analyze spending patterns with visual charts.
- **Category Budgets:** Set and manage budgets for different spending categories.
- **Net Worth Tracking:** Calculate and visualize net worth over time.

## Getting Started

### Prerequisites

- Flutter installed on your development machine (https://flutter.dev/docs/get-started/install).
- A Plaid account and access keys (https://dashboard.plaid.com/signup).

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/splch/butterfly-finance.git
   ```
2. Navigate to the project directory:
   ```
   cd butterfly-finance
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Create a `.env` file in the root of your project and add your Plaid API keys:
   ```
   PLAID_CLIENT_ID=your_client_id_here
   PLAID_SECRET=your_secret_here
   ```
5. Run the app:
   ```
   flutter run
   ```

## Usage

After launching the app, follow the on-screen instructions to link your bank accounts through Plaid. Once your accounts are linked, you can view transaction histories, analyze your spending, manage budgets, and track your net worth directly from the app.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue if you have suggestions or find a bug.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.

## Disclaimer

This app is a demonstration and should be used as such. Please review the Plaid privacy policy and terms of use before linking personal bank accounts.
