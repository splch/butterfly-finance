import 'package:flutter/material.dart';
import 'package:butterfly_finance/models/transaction.dart';

class TransactionsView extends StatefulWidget {
  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    // In a real app, fetch transactions from Plaid here
    fetchTransactions();
  }

  // late String transactionId;
  // late String accountId;
  // late DateTime date;
  // late double amount;
  // late String category;
  // late String description;

  void fetchTransactions() {
    // Mock fetching transactions
    setState(() {
      transactions = [
        Transaction()
          ..transactionId = '1'
          ..accountId = '1'
          ..date = DateTime.utc(2024, 2, 1)
          ..amount = -200.0
          ..category = 'Groceries'
          ..description = 'Groceries for the month',
        Transaction()
          ..transactionId = '2'
          ..accountId = '1'
          ..date = DateTime.utc(2024, 2, 2)
          ..amount = -50.0
          ..category = 'Gas'
          ..description = 'Gas for the car'
        // Add more transactions as needed
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text(transaction.category),
            subtitle: Text('${transaction.date} - \$${transaction.amount}'),
          );
        },
      ),
    );
  }
}
