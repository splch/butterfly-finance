import 'package:flutter/material.dart';

class Account {
  final String name;
  final String type;
  final double balance;

  Account(this.name, this.type, this.balance);
}

class AccountsView extends StatefulWidget {
  @override
  _AccountsViewState createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
  List<Account> accounts = [];

  @override
  void initState() {
    super.initState();
    // Simulate fetching accounts from Plaid
    fetchAccounts();
  }

  void fetchAccounts() async {
    // Here, you'd normally use Plaid's API to fetch account data.
    // This is a mocked list for demonstration.
    final List<Account> fetchedAccounts = [
      Account('Checking', 'Checking Account', 1200.00),
      Account('Savings', 'Savings Account', 5600.50),
      Account('Credit Card', 'Credit Card', -120.75),
    ];

    setState(() {
      accounts = fetchedAccounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connected Accounts'),
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(accounts[index].name),
            subtitle: Text(accounts[index].type),
            trailing: Text('\$${accounts[index].balance.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
