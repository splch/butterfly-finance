import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: '1',
      title: 'Groceries',
      amount: -200.0,
      date: DateTime.utc(2024, 2, 1),
    ),
    Transaction(
      id: '2',
      title: 'Gas',
      amount: -50.0,
      date: DateTime.utc(2024, 2, 2),
    ),
    Transaction(
      id: '3',
      title: 'Paycheck',
      amount: 1000.0,
      date: DateTime.utc(2024, 2, 3),
    ),
    Transaction(
      id: '4',
      title: 'Rent',
      amount: -500.0,
      date: DateTime.utc(2024, 2, 4),
    ),
    // Add more transactions as needed
  ]..sort((a, b) => b.date.compareTo(a.date));

  TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true, // Ensures the ListView only occupies space it needs
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            Transaction transaction = transactions[index];
            return ListTile(
              title: Text(transaction.title),
              subtitle: Text('${transaction.date}'),
              trailing: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            );
          },
        ),
      ),
    );
  }
}

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
