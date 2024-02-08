import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Define a simple transaction model for demonstration
class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}

class TransactionHistoryScreen extends StatelessWidget {
  // Example list of transactions
  final List<Transaction> transactions = [
    Transaction(
        id: 't1',
        title: 'New Shoes',
        amount: 69.99,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 50.53,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: 't3',
        title: 'Electric Bill',
        amount: 75.20,
        date: DateTime.now().subtract(Duration(days: 3))),
    // Add more transactions as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                        '\$${transactions[index].amount.toStringAsFixed(2)}'),
                  ),
                ),
              ),
              title: Text(transactions[index].title,
                  style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(
                DateFormat.yMMMd().format(transactions[index].date),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          );
        },
      ),
    );
  }
}
